class Hash
  def to_flex_arguments
    map{ |key, value|
      "-#{key.to_s.gsub("_","-")}=#{value}"
    }.join(" ")
  end
end

class Compile
  WIDTH, HEIGHT = 1200, 900
  DEFAULTS = { 
    :default_background_color=>"#FFFFFF",
    :default_frame_rate=> 30,
    :incremental=>true,
    :use_network=>false,
    :verbose_stacktraces=>true,
    :warnings=>true
  }
  def self.swf_url(args)
    "bin/#{args[:output]}.swf"
  end
  def self.air(args) 
    build "mxmlc +configname=air " + parse_options(args)
    puts `adl bin/#{args[:output]}.axml`
  end
  
  #
  # args can include:
  # :width, :height, :output, etc...
  # and underscore_versions of the compiler arguments
  #
  def self.swf(args)
    build "mxmlc " + parse_options(args)
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
    swf(args.merge(:paths=>["demos/#{args[:output]}"]))
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
    puts command
    begin
      puts Sprout::FCSHSocket.execute command
    rescue Sprout::FCSHError => e
      raise e
    end
  end
  DEFAULT_PATHS = %w[src assets lib/lbi]
  def self.parse_options(args)
    options = args[:options] ? DEFAULTS.merge(args[:options]) : DEFAULTS
    paths = DEFAULT_PATHS
    paths = args[:paths].concat(DEFAULT_PATHS) unless args[:paths].nil?
    paths = paths.map{|path| "-source-path+=#{path}" }.join(" ")
    "#{options.to_flex_arguments} -default-size #{args[:width]||WIDTH} #{args[:height]||HEIGHT} #{paths}  -o=#{swf_url(args)} #{args[:main]}"
  end
  
end