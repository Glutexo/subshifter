require 'error/negative_time_error'
require 'error/no_time_error'

class Duration
  include Comparable

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

  def <=> compare
    to_f <=> compare.to_f
  end

end