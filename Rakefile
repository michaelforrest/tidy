require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('tidyflash', '0.9.1') do |p|
  p.description    = "Tidy Flash - an ActionScript framework for people who love Ruby"
  p.url            = "http://github.com/michaelforrest/tidy"
  p.author         = "Michael Forrest"
  p.email          = "mf@grimaceworks.com"
  p.ignore_pattern = ["tmp/**/*", "script/*", "tasks/**/*"]
  p.development_dependencies = []
  p.runtime_dependencies = ["sprout", "sprout-flex4sdk-tool","sprout-as3-bundle"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

