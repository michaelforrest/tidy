require "test/unit"
require "open3"
require 'ftools'
class TestTidyProject < Test::Unit::TestCase
  TEST_PROJECT_NAME = "TestProject"
  TEST_PROJECT_FILE_NAME = "test_project"
  AIR_CONFIG_FILE_PATH = "bin/#{TEST_PROJECT_FILE_NAME}.axml"
  def setup
   lib_path = File.expand_path('lib', __FILE__)
   $:.unshift(lib_path) unless $:.include?(lib_path)
  require 'tidy/compile'
    
    Dir.chdir "tmp" do
      puts `rm -fr #{TEST_PROJECT_NAME}`
      require '../lib/tidy_project'
      TidyProject.new(TEST_PROJECT_NAME)
    end
  end
  
  def test_air_main_template
  	in_project_folder do
  		template_path = 'config/templates/air.axml.erb';
  		assert File.exists?(template_path), "Main AIR template should be included in the project on creation"
  		#IO.popen('rake'){ |process| process.each { |line| puts line } }
  		do_silent_rake()
        assert File.exists?(AIR_CONFIG_FILE_PATH), "AXML config file should be auto-generated from root template"
        config_file = File.new(AIR_CONFIG_FILE_PATH,'r')
        assert_equal(
        	get_file_line_from_index(File.new(template_path,'r'), 1),
        	get_file_line_from_index(config_file, 1),
        	"AXML config file should be generated by main template")	
   	end
  end
  
  def test_air_custom_template
  	in_project_folder do
  		File.delete AIR_CONFIG_FILE_PATH if File.exists? AIR_CONFIG_FILE_PATH
  		template_path = "config/templates/#{TEST_PROJECT_FILE_NAME}.axml.erb"
        File.open(template_path, 'w') do |f|
        	f.puts("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
        	f.puts("<application xmlns=\"http://ns.adobe.com/air/application/1.0\">")
        	f.puts("\t<id><%=@app_name.gsub(\" \", \"\")%></id>")
        	f.puts("\t<version><%=@version.chomp%></version>")
        	f.puts("\t<filename><%=@app_name%></filename>")
        	f.puts("\t<initialWindow>")
        	f.puts("\t\t<content><%=@content%></content>")
        	f.puts("\t\t<visible>true</visible>")
        	f.puts("\t\t<x>50</x>")
        	f.puts("\t\t<y>50</y>")
        	f.puts("\t\t<width><%=@width%></width>")
        	f.puts("\t<height><%=@height + 23%></height>")
        	f.puts("\t</initialWindow>")
        	f.puts("</application>")
        end
        do_silent_rake()
        assert File.exists?(AIR_CONFIG_FILE_PATH), "AXML config file should be auto-generated from custom template"
        config_file = File.new(AIR_CONFIG_FILE_PATH,'r')
        assert_equal(
        	get_file_line_from_index(File.new(template_path,'r'), 1),
        	get_file_line_from_index(config_file, 1),
        	"AXML config file should be generated by custom template")
  	end
  end
  
  def do_silent_rake
  	Tidy::Compile.air(:main=>'src/app/views/MainView.as', 
		:output=>TEST_PROJECT_FILE_NAME, 
        :version=> "0.1",
        :do_not_launch=>true)
  end
  
  def get_file_line_from_index(file, index)
  	i = 0;
  	while (line = file.gets)
  		#puts "#{i}: #{line}"
  		if (i==index)
  			return line
  		end
  		i=i+1
  	end
  end

  #def test_add_libs
  #  in_project_folder do
  #    assert File.exists?('script'), "No script folder"
  #    assert File.exists?('rakefile.rb'), "No rakefile"
  #    assert_match "test_project", File.read('rakefile.rb')
  #    assert File.exists?('tasks'), "should be some tasks"
  #    assert File.exists?('bin'), "should be an empty bin folder"
  #  end
  #  
  #end
	#  def test_fcsh
	#    in_project_folder do
	#      Tidy::Compile.air(:main=>'src/app/views/MainView.as', 
	#                  :output=>TEST_PROJECT_FILE_NAME
	#                  #:do_not_launch=>true
	#                  )
	#      end
	#  end

# do packaging
# test content in package

  #def test_build
  #  
  #  in_project_folder do
  #    #puts `rake`
  #    Tidy::Compile.air(:main=>'src/app/views/MainView.as', 
  #                :output=>TEST_PROJECT_FILE_NAME
  #                #:do_not_launch=>true
  #                )
  #    assert File.exists?("bin/#{TEST_PROJECT_FILE_NAME}.swf"), "Rake did not produce swf file"
  #  end
  #end
  #def test_rake
  #  
  #  in_project_folder do
  #    command = "rake --trace"
  #    stdin, stdout, stderr = Open3.popen3(command)
  #    stdout_text = stdout.read
  #    stderr_text = stdout.read
  #    puts "#{stdout_text}\n#{stderr_text}"
  #    assert_no_match /rake aborted/, stderr_text
  #    assert File.exists?("bin/#{TEST_PROJECT_FILE_NAME}.swf"), "Rake did not produce swf file"
  #  end
  #end
  
  private
  def in_project_folder
    Dir.chdir "tmp/#{TEST_PROJECT_NAME}" do
      yield
    end
  end
end