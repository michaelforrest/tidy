require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('tidy', '0.1.4') do |p|
  p.description    = "Tidy Flash - an ActionScript framework for people who love Ruby"
  p.url            = "http://github.com/michaelforrest/tidy"
  p.author         = "Michael Forrest"
  p.email          = "mf@grimaceworks.com"
  p.ignore_pattern = ["tmp/**/*", "script/*", "tasks/**/*"]
  p.development_dependencies = [  ]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
