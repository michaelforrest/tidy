#!/usr/bin/env ruby


require 'socket'
require 'fcntl'
require 'thread'


# Limits the amount of data sent/recv.
# It acts as a authorisation-to-sent/recv-data dispenser
# Whoever wants to send/recv data must call the #dispense method
# to know how many it should send/recv at that time
class BwLimiter
  def initialize(rate, ticks)
    @bytes_per_tick = 1.0*rate/ticks
    @hz = 1.0/ticks
    if @bytes_per_tick < 1 
      raise "rate too low or ticks too high"
    end
    @bytes_per_tick = @bytes_per_tick.round
    if @bytes_per_tick * ticks != rate
      puts "Adjusting rate to #{@bytes_per_tick * ticks}"
    end
    @last_tick = Time.now
  end
  def dispense
    curr = Time.now
    delta = curr - @last_tick
    if delta < @hz
      sleep(@hz - delta)
    end
    #puts "Releasing #{@bytes_per_tick}. Speed = #{@bytes_per_tick / (Time.now - curr)}"
    @last_tick = curr
    @bytes_per_tick
  end
end

class ConstantBwLimiter < BwLimiter
  def initialize
  end
  def dispense
    8192
  end
end



class BwLimiterProxy
  def self.create_producer_thread(name, socket, socket_mutex, 
				  queue, queue_mutex, queue_added_cond,
				  read_limiter, kill_thread_proc)
    Thread.new {
      read_s = nil
      while (1)
	result = select([socket], nil, [socket], nil)
	if result[0].length > 0
	  n_read = read_limiter.dispense
	  #puts "#{name} need to read #{n_read}"
	  socket_mutex.synchronize {
	    read_s = socket.recv(n_read)
	  }
	  if (read_s.length == 0)
	    #puts "#{name} closed"
	    kill_thread_proc.call
	    break # or Thread.stop
	  else
	    queue_mutex.synchronize {
	      read_s.split(//).each {|i| queue << i}
	      #puts "#{name}: read #{read_s.length}"
	      queue_added_cond.signal
	    }
	  end
	elsif result[2].length > 0
	  raise "#{name} read error"
	end
      end
    }
  end



  def self.create_consumer_thread(name, socket, socket_mutex, 
				  queue, queue_mutex, queue_added_cond,
				  write_limiter)
    my_queue = nil
    Thread.new{
      while (1)
	queue_mutex.synchronize {
	  queue_added_cond.wait(queue_mutex)
	  my_queue = queue.clone
	  queue.clear
	}
	while (my_queue && my_queue.length > 0)
	  result = select(nil, [socket], [socket], nil)
	  if result[1].length > 0
	    n_write = write_limiter.dispense
	    socket_mutex.synchronize {
	      n_write = socket.send(my_queue[0..n_write].join, 0)
	    }
	    my_queue.slice!(0..n_write);
	    #puts "REMOTE: written #{n_write}"
	  elsif result[2].length > 0
	    raise "#{name} send error"
	  end
	end
      end
    }
  end
  


  def self.make_nonblocking(io)
    io.fcntl(Fcntl::F_SETFD, io.fcntl(Fcntl::F_GETFD) | Fcntl::O_NONBLOCK)
  end


  def self.make_proc_kill_thread(t_parent)
    proc{t_parent[:thread_list].each {|t| 
	t.kill if Thread.current != t
	#puts "Killed: #{t.inspect}"; 
      }
    }
  end

    
  attr_reader :is_global_limit
  attr_reader :input_rate
  attr_reader :output_rate
  attr_reader :ticks
  attr_reader :input_limiter
  attr_reader :output_limiter
  
  def session(l_socket, r_socket)
    [l_socket, r_socket].each {|io|
      BwLimiterProxy.make_nonblocking io
    }
    
    proc_kill_thread =  BwLimiterProxy.make_proc_kill_thread(Thread.current)
    
    if @is_global_limit
      input_limiter = @input_limiter
      output_limiter = @output_limiter
    else
      t_current = Thread.current;
      input_limiter = BwLimiter.new(@input_rate, @ticks)
      output_limiter = BwLimiter.new(@output_rate, @ticks)
    end
    local_input_limiter = ConstantBwLimiter.new
    local_output_limiter = ConstantBwLimiter.new

    outgoing_queue = [] #from l->r
    outgoing_mutex = Mutex.new
    outgoing_produced = ConditionVariable.new

    incoming_queue = [] #from r->l
    incoming_mutex = Mutex.new
    incoming_produced = ConditionVariable.new
    
    l_socket_mutex = Mutex.new
    r_socket_mutex = Mutex.new

    t_outgoing_producer = 
      BwLimiterProxy.create_producer_thread("LOCAL", l_socket, l_socket_mutex,
					    outgoing_queue, outgoing_mutex, 
					    outgoing_produced,
					    local_output_limiter, 
					    proc_kill_thread)
    t_incoming_producer = 
      BwLimiterProxy.create_producer_thread("REMOTE", r_socket, r_socket_mutex,
					    incoming_queue, incoming_mutex, 
					    incoming_produced,
					    input_limiter, 
					    proc_kill_thread)
    t_outgoing_consumer = 
      BwLimiterProxy.create_consumer_thread("REMOTE", r_socket, r_socket_mutex,
					    outgoing_queue, outgoing_mutex, 
					    outgoing_produced,
					    output_limiter)
    t_incoming_consumer =
      BwLimiterProxy.create_consumer_thread("LOCAL", l_socket, l_socket_mutex,
					     incoming_queue, incoming_mutex, 
					     incoming_produced,
					     local_input_limiter)
    
    t_current = Thread.current
    t_current[:thread_list] = [t_outgoing_producer, t_incoming_producer, 
      t_outgoing_consumer, t_incoming_consumer]
    #t_current[:thread_list].each{|t| puts "Threads: #{t.inspect}"}

    t_current[:thread_list].each {|t| 
      t.join; 
      #puts "Joined: #{t.inspect}"; 
    }
    l_socket.close
    r_socket.close
    #puts "Exiting cleanly"
  end


  def initialize(input_rate, output_rate, is_global_limit, ticks)
    @input_rate = input_rate
    @output_rate = output_rate
    @ticks = ticks
    if @is_global_limit = is_global_limit
      @input_limiter = BwLimiter.new(@input_rate, @ticks)
      @output_limiter = BwLimiter.new(@output_rate, @ticks)
    end
  end
end


def print_help
  puts <<-EOF
  # #{$0} [options] rhost rport
  #
  # --lhost x           listen to the interface x (def: localhost)
  # --lport x           listen to port x (def: 8119)
  # --outgoing-rate x
  # -o x                output at x KBps (def: 5)
  # --incoming-rate x
  # -i x                accepts input at xKBps (def: 5)
  # --global-limit
  # -g                  if set, the rate is for total rate (def: the rate is per connection)
  # --ticks
  # -t                  ticks per second, higher more accurate but consumes more cpu (def: 100)
  # --help
  # -h                  this page
  # rhost               host to connect to
  # rport               port to connect to
  EOF
end							    



if $0 == __FILE__
  require 'getoptlong'

  if ARGV.length < 2
    print_help
    exit
  end
  opts = GetoptLong.new(["--lhost", GetoptLong::REQUIRED_ARGUMENT ],
			["--lport", GetoptLong::REQUIRED_ARGUMENT ],
			["--outgoing-rate", "-o", GetoptLong::REQUIRED_ARGUMENT ],
			["--incoming-rate", "-i", GetoptLong::REQUIRED_ARGUMENT ],
			["--outgoing-rate-byte", "--orb",  GetoptLong::REQUIRED_ARGUMENT ],
			["--incoming-rate-byte", "--irb", GetoptLong::REQUIRED_ARGUMENT ],
			["--global-limit", "-g", GetoptLong::NO_ARGUMENT],
			["--ticks", "-t", GetoptLong::REQUIRED_ARGUMENT],
			["--help", "-h", GetoptLong::NO_ARGUMENT])
  hopts = {}
  opts.each {|opt, arg|
    hopts[opt] = arg
  }
  if ARGV.length != 2
    print_help
  end

  
  LPORT = (hopts["--lport"] || 8119).to_i
  LHOST = hopts["--lhost"] || "localhost"
  OUTGOING_RATE = (hopts["--outgoing-rate"] || 5).to_i * 1024
  INCOMING_RATE = (hopts["--incoming-rate"] || 5).to_i * 1024
  IS_GLOBAL_LIMIT = if hopts["--global-limit"] then true else false end
  TICKS = (hopts["--ticks"] || 100).to_i
  RHOST = ARGV[0]
  RPORT = ARGV[1].to_i
  
  if hopts["--outgoing-rate-byte"]
    OUTGOING_RATE = hopts["--outgoing-rate-byte"].to_i
  end
  if hopts["--incoming-rate-byte"]
    INCOMING_RATE = hopts["--incoming-rate-byte"].to_i
  end

  puts "LPORT=#{LPORT}"
  puts "LHOST=#{LHOST}"
  puts "OUTGOING_RATE=#{OUTGOING_RATE}"
  puts "INCOMING_RATE=#{INCOMING_RATE}"
  puts "TICKS=#{TICKS}"
  puts "IS_GLOBAL_LIMIT=#{IS_GLOBAL_LIMIT.to_s}"
  puts "RHOST=#{RHOST}"
  puts "RPORT=#{RPORT}"

  threads = []
  threads_mutex = Mutex.new
  proxy = BwLimiterProxy.new(INCOMING_RATE, OUTGOING_RATE, IS_GLOBAL_LIMIT, TICKS)
  server = TCPServer.new(LHOST, LPORT)
  #server.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
  puts "Ready"
  while (local_socket = server.accept)
    begin
      remote_socket = TCPSocket.new(RHOST, RPORT)
      t = Thread.new { 
	proxy.session(local_socket, remote_socket)
	threads_mutex.synchronize { threads.delete_if{|t| Thread.current == t}}
	puts "Now serving #{threads.size} connections"
      }
      threads_mutex.synchronize { threads << t }
      puts "Now serving #{threads.size} connections"
    rescue => e
      p e
    end
  end
end
