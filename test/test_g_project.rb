require "test/unit"
require 'lib/g_project'
require 'ftools'
class TestGProject < Test::Unit::TestCase
  PROJECT_FOLDER = 'tmp/TestProject'
  def setup
    jump_into(PROJECT_FOLDER)
  end
  def test_add_libs
    GProject.new
    Dir.mkdir('script')
    assert File.exists?('script/lbi')
  end
  def jump_into(dir)
    Dir.rmdir(dir) if File.exists?(dir)
    Dir.mkdir(dir)
    Dir.chdir(dir)
  end
end