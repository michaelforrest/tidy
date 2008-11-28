require 'test/unit'
require 'script/lbi/lib/as2_class'
class TestFlashProject < Test::Unit::TestCase
  def setup
  end
  def teardown
  end
  METHOD_COUNT = 5
  FIELD_COUNT = 3
  IMPORT_COUNT = 5
  def test_sample_class
    sample = LBi::AS2Class.new('script/lbi/lib/test/SampleClass.as')
    assert_equal METHOD_COUNT, sample.get_methods.length, "result: #{sample.get_methods}"
  end
end