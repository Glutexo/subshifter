require 'test/unit'
require 'duration'

class DurationTest < Test::Unit::TestCase

  def test_can_be_initialized_with_second_count
    seconds = 120.123
    duration = Duration.new seconds
    assert_equal seconds, duration.to_f
  end

  def test_can_add_by_plus
    base = 120.123
    duration = Duration.new base
    addition = 12.345
    duration += addition

    assert duration.is_a? Duration
    assert_equal base + addition, duration.to_f
  end

end