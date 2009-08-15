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
    puts "adding library to this project's #{dest} folder"
    dest = "#{@project_dir}/#{dest}/"
    FileUtils.mkdir_p(dest)
    FileUtils.cp_r("#{File.dirname(File.expand_path(__FILE__))}/#{source}", dest)

  end
   
end
