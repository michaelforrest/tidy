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

require 'sprout/user'
require 'sprout/fcsh_socket'
require "#{File.expand_path(File.dirname(__FILE__))}/axml"

module Tidy
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
    #
    # args can include:
    # :width, :height, :output, etc...
    # and underscore_versions of the compiler arguments
    def self.air(args) 
      build args, "mxmlc +configname=air " + parse_options(args.merge(:options=>{:define=>["CONFIG::air,true","CONFIG::swf,false"]}))
      Axml.new( args )
      unless args[:do_not_launch]
        File.delete File.expand_path("~/mm.cfg") if File.exists? File.expand_path("~/mm.cfg")
        puts `adl bin/#{args[:output]}.axml`
      end
    end
  
  
    #
    # TODO: make adl launch an air file with a webkit instance and the swf inside it
    #
    def self.swf(args)

    end
    # usage: DemoConfig.new(:vars=>{:varName=>'value', :anotherVar=>2.4}, :output=>'variation')
    def self.demo(args)
      DemoConfig.new(:vars=>args[:vars] || {}, 
                    :class=>'DemoConfig', 
                    :output=>"demos/#{args[:output]}/DemoConfig.as")
      air(args.merge(:paths=>["demos/#{args[:output]}"]))
    end
  
    def self.build(args,command)
      #puts "cd #{FileUtils.pwd} && #{command}"
      command_result = command
      filtered_result = command_result.to_a.map{|l| l unless l.match(/^Reason|^Recompile/)}.compact
      puts filtered_result
      
      unless File.exists?(swf_url args)
        puts "Building for first time"
        require 'open3'
        stdin, stdout, stderr = Open3.popen3(command)
        puts "#{stdout.read}\n#{stderr.read}"
        return
      end
      
      result =  Sprout::FCSHSocket.execute command
 
      if (result =~ /fcsh: Target \d+ not found/)
          puts "*******************"
          puts "* Starting FCSH   *"
          puts "*******************"
          #raise e
      end
    end
    DEFAULT_PATHS = %w[src assets ~/.tidy/tidy-as3]
    def self.parse_options(args)
      options = args[:options] ? DEFAULTS.merge(args[:options]) : DEFAULTS
      paths = DEFAULT_PATHS
      paths = args[:paths].concat(DEFAULT_PATHS) unless args[:paths].nil?
      paths = paths.map{|path| "-source-path+=#{File.expand_path path}" }.join(" ")
      "#{options.to_flex_arguments} -default-size #{args[:width]||WIDTH} #{args[:height]||HEIGHT} #{paths}  -o=#{File.expand_path swf_url(args)} #{File.expand_path args[:main]}"
    end
  
  end
end