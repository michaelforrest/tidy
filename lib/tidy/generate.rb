#!/usr/bin/env ruby
require 'rubygems'
require 'active_support'
require 'tidy/template'
#LANGUAGE = 'as3' #TODO: un-hard-code
#SCRIPT_PATH = File.join("script", LANGUAGE)
#def available_templates
#  Dir.entries(SCRIPT_PATH).collect{|e| e unless e[0]==46}.compact
#end

module Tidy
  require 'erb'
  require 'fileutils'
  class Generate
    def initialize(options={:template_id=>nil})
      Template.new(options)
    end
  end
end

