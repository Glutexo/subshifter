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

  def to_s
    seconds = @seconds % 60
    total_minutes = (@seconds / 60).floor
    minutes = total_minutes % 60
    hours = (total_minutes / 60).floor
    "#{'%02d' % hours}:#{'%02d' % minutes}:#{('%0.3f' % seconds).tr '.', ','}"
  end

end