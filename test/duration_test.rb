require 'test/unit'
require 'duration'

class DurationTest < Test::Unit::TestCase

  def test_can_be_initialized_with_second_count
    seconds = 120.123
    duration = Duration.new seconds
    assert_equal seconds, duration
  end

  def test_can_add_by_plus
    base = 120.123
    duration = Duration.new base
    addition = 12.345
    duration += addition

    assert duration.is_a? Duration
    assert_equal base + addition, duration
  end

  def test_can_subtract_by_minus
    base = 120.123
    duration = Duration.new base
    subtraction = 12.345
    duration -= subtraction

    assert duration.is_a? Duration
    assert_equal base - subtraction, duration
  end

  def test_can_be_compared_with_fixnum
    base = 120.123
    assert_equal base, Duration.new(base)
  end

  def test_can_be_compared_equal_with_another_duration
    base = 120.123
    assert_equal Duration.new(base), Duration.new(base)
  end

  def test_cannot_be_initialized_as_negative
    assert_raise NegativeTimeError do
      Duration.new -1
    end
  end

  def test_cannot_be_shifted_to_negative
    duration = Duration.new 1
    assert_raise NegativeTimeError do
      duration -= 1.1
    end
  end

  def test_can_be_compared_greater_with_another_duration
    assert Duration.new(3) > Duration.new(2)
    assert !(Duration.new(3) > Duration.new(4))
  end

  def test_can_be_compared_lesser_with_another_duration
    assert Duration.new(2) < Duration.new(3)
    assert !(Duration.new(4) < Duration.new(3))
  end

  def test_can_be_written
    assert_equal "03:25:45,678", Duration.new(12345.678).to_s
  end

end