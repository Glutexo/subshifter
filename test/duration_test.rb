require 'test/unit'
require 'duration'

class DurationTest < Test::Unit::TestCase

  def test_can_be_initialized_with_second_count
    seconds = 120.123
    duration = Duration.new seconds
    assert_equal seconds, duration.to_f
  end

end