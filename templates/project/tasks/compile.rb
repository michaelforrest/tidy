class Hash
  def to_flex_arguments
    map{ |key, value|
      key = key.to_s.gsub("_","-")
      if (value.class == Array)
        value.map{|v| "-#{key}=#{v}" }.join(" ")
      else
        "-#{key}=#{value}"
      end
    }.join(" ")
  end
end

class Compile
  WIDTH, HEIGHT = 1200, 900
  DEFAULTS = { 
    :default_background_color=>"#000000",
    :default_frame_rate=> 60,
    #:incremental=>true,
    :use_network=>false,
    :verbose_stacktraces=>true
    #:warnings=>true
  }
  def self.swf_url(args)
    "bin/#{args[:output]}.swf"
  end
  def self.air(args) 
    build "mxmlc +configname=air " + parse_options(args.merge(:options=>{:define=>["CONFIG::air,true","CONFIG::swf,false"]}))
    Axml.new( args.merge(:version=> `bzr revno`) )
    File.delete File.expand_path("~/mm.cfg") if File.exists? File.expand_path("~/mm.cfg")
    puts `adl bin/#{args[:output]}.axml`
    
  end
  
  #
  # args can include:
  # :width, :height, :output, etc...
  # and underscore_versions of the compiler arguments
  #
  def self.swf(args)
    build "mxmlc " + parse_options(args.merge(:options=>{:define=>["CONFIG::swf,true","CONFIG::air,false"]}))
    player = CLIXFlashPlayer.new
    
    player.execute('/Applications/Adobe\ Flash\ CS4/Players/Debug/Flash\ Player.app', swf_url(args))
    
    log_file = "/Users/michaelforrest/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt"
    unless File.exists?("/Users/michaelforrest/mm.cfg")
      File.open("/Users/michaelforrest/mm.cfg",'w') do |f|
        f.write <<-EOF
          ErrorReportingEnable=1
          MaxWarnings=0
          TraceOutputEnable=1
          TraceOutputFileName=#{log_file}
        EOF
      end
    end
    `echo "" > "#{log_file}"`
    read_log(player,log_file)
    player.join
    
  end
  # usage: DemoConfig.new(:vars=>{:varName=>'value', :anotherVar=>2.4}, :output=>'variation')
  def self.demo(args)
    DemoConfig.new(:vars=>args[:vars] || {}, 
                  :class=>'DemoConfig', 
                  :output=>"demos/#{args[:output]}/DemoConfig.as")
    air(args.merge(:paths=>["demos/#{args[:output]}"]))
  end
  
  def self.read_log(thread, log_file)
    lines_put = 0

    if(!File.exists?(log_file))
      raise Error.new('[ERROR] Unable to find the trace output log file in the expected location: ' + log_file)
    end

    while(thread.alive?)
      sleep(0.2)
      lines_read = 0

      File.open(log_file, 'r') do |file|
        file.readlines.each do |line|
          lines_read = lines_read + 1
          if(lines_read > lines_put)
            #if(!parse_test_result(line, thread))
              puts "[trace] #{line}"
            #end
            $stdout.flush
            lines_put = lines_put + 1
          end
        end
      end
    end
  end

  def self.build(command)
    #puts "cd #{FileUtils.pwd} && #{command}"
    command_result = command
    filtered_result = command_result.to_a.map{|l| l unless l.match(/^Reason|^Recompile/)}.compact
    puts filtered_result
    #begin
    puts "Send to socket #{Sprout::FCSHSocket}"
    result =  Sprout::FCSHSocket.execute command
    puts result
    #rescue Exception => e
    #  puts "*****"
    #  puts "* Not using fcsh - you can speed up compilation by running rake fcsh:start in another terminal"
    #  puts "*****"
    #  puts `command`
    #  #raise e
    #end
  end
  DEFAULT_PATHS = %w[src assets lib/tidy common]
  def self.parse_options(args)
    options = args[:options] ? DEFAULTS.merge(args[:options]) : DEFAULTS
    paths = DEFAULT_PATHS
    paths = args[:paths].concat(DEFAULT_PATHS) unless args[:paths].nil?
    paths = paths.map{|path| "-source-path+=#{File.expand_path path}" }.join(" ")
    "#{options.to_flex_arguments} -default-size #{args[:width]||WIDTH} #{args[:height]||HEIGHT} #{paths}  -o=#{File.expand_path swf_url(args)} #{File.expand_path args[:main]}"
  end
  
end