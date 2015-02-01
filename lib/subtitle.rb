class Subtitle < File
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
