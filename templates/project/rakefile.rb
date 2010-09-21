require 'rubygems'
require 'tidy/compile'
require 'tidy/air_packager'
Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
#desc 'compile and run air app (needs a couple of extra files manually created so far)' 
#task :air do |t|
#  Compile.air :main=>"src/Fubuntu.as", :output=>"Fubuntu-air"  
#end

desc 'Compile and run the test harness'
task :test do |t|
  Compile.air :main=>"src/FubuntuRunner.as", :output=>"Fubuntu-test", :paths=>['test','lib/asunit3']
end

desc 'Compile and run app'
task :app do
  Tidy::Compile.air(:main=>'src/app/views/MainView.as', 
              :output=>"<%= @project_name.underscore %>", 
              :version=> "0.1",
              :width=>1024,
              :height=>768,
              :default_background_color=>"#FFFFFF")

end
task :package do
  Tidy::AirPackager.package(:id=>"<%= @project_name.underscore %>")
end

#desc "regression tester"
#regress :regress do |t|
#  t.input = "features/RegressionTestView.as"
#end


# set up the default rake task
task :default => :app

