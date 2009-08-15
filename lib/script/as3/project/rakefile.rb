require 'clix_flash_player'
require 'sprout/user'
require 'sprout/tasks/fcsh'
require 'lib/tasks/demo_config'
require 'lib/tasks/compile'
require 'lib/tasks/assets'

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
  Compile.swf :main=>'src/app/views/AppView.as', :output=>"<%= @project_name.underscore %>"
end

#desc "regression tester"
#regress :regress do |t|
#  t.input = "features/RegressionTestView.as"
#end


# set up the default rake task
task :default => :app

