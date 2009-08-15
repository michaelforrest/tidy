require "test/unit"

require 'ftools'
class TestTidyProject < Test::Unit::TestCase
  def test_add_libs
    Dir.chdir "tmp" do
      puts `rm -fr TestProject`
      require '../lib/tidy_project'
      TidyProject.new("TestProject")
      Dir.chdir "TestProject" do
        assert File.exists?('script'), "No script folder"
        assert File.exists?('rakefile.rb'), "No rakefile"
        assert_match "test_project", File.read('rakefile.rb')
        assert File.exists?('lib/tasks'), "should be some tasks"
        assert File.exists?('bin'), "should be an empty bin folder"
      end
    end
  end
end