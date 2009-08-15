require "test/unit"
require 'lib/tidy_project'
require 'ftools'
class TestTidyProject < Test::Unit::TestCase
  PROJECT_NAME = 'tmp/TestProject'
  def setup
   # jump_into(PROJECT_FOLDER)
   
  end
  def test_add_libs
    Dir.chdir "tmp" do
      puts `rm -fr #{PROJECT_NAME}`
      TidyProject.new(PROJECT_NAME)
      Dir.chdir PROJECT_NAME do
        assert File.exists?('script'), "No script folder"
        assert File.exists?('rakefile.rb'), "No rakefile"
      end
    end
  end
  #def jump_into(dir)
  #  #Dir.rmdir(dir) 
  #  Dir.mkdir(dir) unless File.exists?(dir)
  #  Dir.chdir(dir)
  #end
end