require 'fileutils'
$:.unshift(File.expand_path('..', __FILE__))
require 'tidy/generate'
class TidyProject
  
 
  def initialize(project_name)
    @project_dir = project_name
    raise "Project already exists" if File.exists? project_name
    FileUtils.mkdir_p(project_name)
    Dir.chdir(@project_dir) do
       Tidy::Generate.new(:template_id=>'project', :args=>[project_name])
    end
  end
  
   
end
