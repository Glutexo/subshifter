=begin
Single subtitle chunk. Dialog part with a begin and end timestamp.
Both timestamps can be manipulated at the same time using the
shift method or the +/- operators.
=end

require 'duration'
require 'error/empty_body_error'
require 'error/parse_error'
class SubtitleChunk
  attr_reader :body, :begin, :end

  # Can be initialized either from a string in the SRT format,
  # or from a hash of the begin and end timestamps and the body.
  def initialize chunk
    if chunk.is_a? Hash
      @body = chunk[:body]
      @begin = Duration.new chunk[:begin]
      @end = Duration.new chunk[:end]
    else
      chunk.match /^\d+(?<NEWLINE>\r?\n)(?<BEGIN>(?<TIME>\d{2}:\d{2}:\d{2},\d{3})) --> (?<END>\g<TIME>)\k<NEWLINE>(?<BODY>.+)$/m do |match|
        @body = match['BODY']
        @begin = duration match['BEGIN']
        @end = duration match['END']
      end or raise ParseError.new "Invalid subtitle chunk: #{chunk}"
    end

    @body.strip!
    raise EmptyBodyError.new "Body cannot be empty." if @body.empty?
  end

  def shift! seconds
    shifted = self + seconds
    @begin, @end = shifted.begin, shifted.end
  end

  def shift seconds
    self + seconds
  end

  def + seconds
    SubtitleChunk.new body: @body,
                 begin: @begin + seconds,
                 end: @end + seconds
  end

  def - seconds
    self + (-seconds)
  end

  protected
  # Parse the SRT timestamp format HH:MM:SS,SSS into Duration.
  def duration stamp
    stamp.match /(?<HOURS>\d{2}):(?<MINUTES>\d{2}):(?<SECONDS>\d{2}),(?<MILLISECONDS>\d{3})/ do |match|
      hours = match['HOURS'].to_f
      minutes = hours * 60 + match['MINUTES'].to_f
      seconds = minutes * 60 + "#{match['SECONDS']}.#{match['MILLISECONDS']}".to_f
      Duration.new seconds
    end or raise ArgumentError.new "Invalid duration stamp: #{stamp}"
  end

end
