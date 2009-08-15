require "test/unit"
require 'lib/tidy_project'
require 'ftools'
class TestTidyProject < Test::Unit::TestCase
  PROJECT_FOLDER = 'tmp/TestProject'
  def setup
   # jump_into(PROJECT_FOLDER)
   
  end
  def test_add_libs
    TidyProject.new(PROJECT_FOLDER)
    Dir.chdir PROJECT_FOLDER do
      assert File.exists?('script'), "No script folder"
      assert File.exists?('rakefile'), "No rakefile"
    end
  end
  #def jump_into(dir)
  #  #Dir.rmdir(dir) 
  #  Dir.mkdir(dir) unless File.exists?(dir)
  #  Dir.chdir(dir)
  #end
end