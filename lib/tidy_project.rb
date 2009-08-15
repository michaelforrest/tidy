require 'fileutils'
class TidyProject
  
  LANGUAGE = 'as3'
  def initialize(project_name)
    @project_dir = project_name
    folder('script', '.')
    folder("aslibs/#{LANGUAGE}/lbi", 'lib')
    Dir.chdir(@project_dir) do
      command = "./script/generate project #{project_name}"
      puts "running #{command}"
      puts `#{command}` 
    end
  end
  def folder(source,dest)
    dest = "#{@project_dir}/#{dest}/"
    source = "#{File.dirname(File.expand_path(__FILE__))}/#{source}"
    puts "adding '#{source}' to this project's '#{dest}' folder"
    puts FileUtils.mkdir_p(dest)
    puts FileUtils.cp_r(source, dest)
  end
   
end
