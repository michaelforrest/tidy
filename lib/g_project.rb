require 'fileutils'
class GProject
  LANGUAGE = 'as3'
  def initialize(options={:dir=>"."})
    @project_dir = options[:dir]
    puts 'Run this in your project folder after sprouts -n as3 SomeProject (will automate and make this all simpler soon)'
    puts "====================================================================="
    puts `pwd`
    puts File.expand_path(__FILE__)
    puts "====================================================================="
    folder('script/lbi', 'script')
    folder("aslibs/#{LANGUAGE}/lbi", 'lib')
  end
  def folder(source,dest)
    puts "adding library to this project's #{dest} folder"
    dest = "#{@project_dir}/#{dest}/"
    FileUtils.mkdir_p(dest)
    FileUtils.cp_r("#{File.dirname(File.expand_path(__FILE__))}/#{source}", dest)

  end
   
end
