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
require "#{File.expand_path(File.dirname(__FILE__))}/version"
require "#{File.expand_path(File.dirname(__FILE__))}/demo_config"

def method_name
  
end

module Tidy
  class Compile
    WIDTH, HEIGHT = 1200, 900
    DEFAULTS = { 
      :default_background_color=>"#000000",
      :default_frame_rate=> 30,
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
      build args, "mxmlc +configname=air " + parse_options(args)
      Axml.new( args )
      unless args[:do_not_launch]
      	#if File.exists? File.expand_path("~/mm.cfg")
        #	File.rename(File.expand_path("~/mm.cfg"), File.expand_path("~/mm.cfg") + ".bak")
        #end
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
                    :output=>"src/DemoConfig.as")
      air(args.merge(:paths=>["src"]))
    end
    
    def self.get_compile_command(args, initial_command)
    	command = initial_command + " " + parse_options(args)
    	command_result = command
      	return command
    end
  
    def self.build(args,command)
      puts "Compiling with TidyFlash #{Tidy::Version.number}"
      puts "will execute: #{command}"
      #puts "cd #{FileUtils.pwd} && #{command}"
=begin
      command_result = command
      filtered_result = command_result.to_a.map{|l| l unless l.match(/^Reason|^Recompile/)}.compact
      puts filtered_result
=end
      IO.popen(command){ |process| process.each { |line| puts line } }
    end
    DEFAULT_PATHS = %w[src assets ~/.tidy/tidy-as3]
    def self.parse_options(args)
      options = DEFAULTS.dup()
      options.each_pair do |k,v|
		options[k] = args[k] unless args[k].nil?
	  end
      paths = DEFAULT_PATHS
      paths = args[:paths].concat(DEFAULT_PATHS) unless args[:paths].nil?
      paths = paths.map{|path| "-source-path+=#{File.expand_path path}" }.join(" ")
      "#{options.to_flex_arguments} -default-size #{args[:width]||WIDTH} #{args[:height]||HEIGHT} #{paths}  -o=#{File.expand_path swf_url(args)} #{File.expand_path args[:main]}"
    end
  
  end
end