require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('g-project', '0.1.0') do |p|
  p.description    = "Generate a project in Grimaceworks/LBi Standard Format"
  p.url            = "http://github.com/michaelforrest/g-project"
  p.author         = "Michael Forrest"
  p.email          = "mike@grimaceworks.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = [  ]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }