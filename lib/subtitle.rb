=begin
A whole subtitle stream consisting of chunks representing the
single dialogs. Accepts an IO object (e.g. a File) or a string
itself in the SRT format.
=end

require 'subtitle_chunk'

class Subtitle
  attr_reader :chunks

  def initialize input
    if input.is_a? Array
      @chunks = input
    else
      input = input.read if input.respond_to? :read

      @chunks = []

      chunks = input.split /(\r?\n){2}/
      chunks.each do |chunk|
        chunk.strip!
        @chunks << SubtitleChunk.new(chunk) unless chunk.empty?
      end
    end
  end

  def initialize_copy source
    super
    @chunks = @chunks.dup
    @chunks.map! { |chunk| chunk.dup }
  end

  def to_s
    @chunks.map.with_index { |chunk, order| chunk.to_s(order + 1) }.join "\n"
  end

  def shift seconds
    subtitle = self.dup
    subtitle.shift! seconds
  end

  def shift! seconds
    @chunks.each do |chunk|
      chunk.shift! seconds
    end
    self
  end

end
