=begin
A whole subtitle stream consisting of chunks representing the
single dialogs. Accepts an IO object (e.g. a File) or a string
itself in the SRT format.
=end

class Subtitle
  attr_reader :chunks

  def initialize input
    input = input.read if input.respond_to? :read

    @chunks = []

    chunks = input.split /(\r?\n){2}/
    chunks.each do |chunk|
      chunk.strip!
      @chunks << SubtitleChunk.new(chunk) unless chunk.empty?
    end
  end

end
