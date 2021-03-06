require 'fileutils'
require 'open3'
$:.unshift(File.expand_path('..', __FILE__))
require 'tidy/generate'
class TidyProject
  
 
  def initialize(project_name)
    unless File.exists?(File.expand_path("~/.tidy/tidy-as3"))
      puts "You don't have the tidy as3 libs installed. Attempting to pull them from github..."
      command = "git clone http://github.com/michaelforrest/tidy-as3.git ~/.tidy/tidy-as3"
      puts command
      IO.popen(command) { |process| process.each { |line| puts line } }
    end
    @project_dir = project_name
    raise "Project already exists" if File.exists? project_name
    FileUtils.mkdir_p(project_name)
    Dir.chdir(@project_dir) do
       Tidy::Generate.new(:template_id=>'project', :args=>[project_name])
    end
  end
  
   
end
