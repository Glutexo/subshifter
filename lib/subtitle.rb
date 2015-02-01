require 'pp'

class Subtitle
  attr_reader :body, :begin, :end

  def initialize chunk
    chunk.match /^\d+(?<NEWLINE>\r?\n)(?<BEGIN>(?<TIME>\d{2}:\d{2}:\d{2},\d{3})) --> (?<END>\g<TIME>)\k<NEWLINE>(?<BODY>.+)$/m do |match|
      @body = match['BODY']
      @begin = duration match['BEGIN']
      @end = duration match['END']
    end or raise ArgumentError.new "Invalid subtitle chunk: #{chunk}"
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
