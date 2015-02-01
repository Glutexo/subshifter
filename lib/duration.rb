class Duration

  def initialize seconds
    @seconds = seconds.to_f
  end

  def to_f
    @seconds
  end

  def + add
    Duration.new(@seconds + add)
  end

  def - subtract
    self + (-subtract)
  end

  def == compare
    if compare.is_a? Numeric then self.to_f == compare else super end
  end

end