require "test/unit"

require 'ftools'
class TestTidyProject < Test::Unit::TestCase
  TEST_PROJECT_NAME = "TestProject"
  TEST_PROJECT_FILE_NAME = "test_project"
  def setup
    Dir.chdir "tmp" do
      puts `rm -fr #{TEST_PROJECT_NAME}`
      require '../lib/tidy_project'
      TidyProject.new(TEST_PROJECT_NAME)
    end
  end

  def test_add_libs
    in_project_folder do
      assert File.exists?('script'), "No script folder"
      assert File.exists?('rakefile.rb'), "No rakefile"
      assert_match "test_project", File.read('rakefile.rb')
      assert File.exists?('tasks'), "should be some tasks"
      assert File.exists?('bin'), "should be an empty bin folder"
    end
  end
  
  def test_build
    require 'tidy/compile'
    in_project_folder do
      #puts `rake`
      Tidy::Compile.air(:main=>'src/app/views/MainView.as', 
                  :output=>TEST_PROJECT_FILE_NAME
                  #:do_not_launch=>true
                  )
      assert File.exists?('bin/#{TEST_PROJECT_FILE_NAME}.swf'), "Rake did not produce swf file"
    end
  end
  
  private
  def in_project_folder
    Dir.chdir "tmp/#{TEST_PROJECT_NAME}" do
      yield
    end
  end
end