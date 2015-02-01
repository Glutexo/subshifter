require 'error/negative_time_error'
require 'error/no_time_error'

class Duration

  def initialize seconds
    raise NoTimeError.new "Time must be set." if seconds.nil?

    @seconds = seconds.to_f
    raise NegativeTimeError.new "Duration cannot be negative." if @seconds < 0
  end

  def to_f
    @seconds
  end

  def + add
    shifted = @seconds + add
    Duration.new(shifted)
  end

  def - subtract
    self + (-subtract)
  end

  def == compare
    if compare.is_a?(Numeric) || compare.is_a?(Duration)
      self.to_f == compare
    else
      super
    end
  end

end