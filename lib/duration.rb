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

end