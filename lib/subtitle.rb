require 'pp'

class Subtitle
  attr_reader :body, :begin, :end

  def initialize chunk
    if chunk.is_a? Hash
      @body = chunk[:body]
      @begin = Duration.new chunk[:begin]
      @end = Duration.new chunk[:end]
    else
      chunk.match /^\d+(?<NEWLINE>\r?\n)(?<BEGIN>(?<TIME>\d{2}:\d{2}:\d{2},\d{3})) --> (?<END>\g<TIME>)\k<NEWLINE>(?<BODY>.+)$/m do |match|
        @body = match['BODY'].chomp
        @begin = duration match['BEGIN']
        @end = duration match['END']
      end or raise ArgumentError.new "Invalid subtitle chunk: #{chunk}"
    end

    raise ArgumentError.new "Body cannot be empty." if @body.empty?
  end

  def shift! seconds
    shifted = self + seconds
    @begin, @end = shifted.begin, shifted.end
  end

  def shift seconds
    self + seconds
  end

  def + add
    Subtitle.new body: @body,
                 begin: @begin + add,
                 end: @end + add
  end

  def - subtract
    self + (-subtract)
  end

  protected
  def duration stamp
    stamp.match /(?<HOURS>\d{2}):(?<MINUTES>\d{2}):(?<SECONDS>\d{2}),(?<MILLISECONDS>\d{3})/ do |match|
      hours = match['HOURS'].to_f
      minutes = hours * 60 + match['MINUTES'].to_f
      seconds = minutes * 60 + "#{match['SECONDS']}.#{match['MILLISECONDS']}".to_f
      Duration.new seconds
    end or raise ArgumentError.new "Invalid duration stamp: #{stamp}"
  end

end
