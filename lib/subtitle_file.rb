class SubtitleFile < File
  attr_reader :subtitles

  def parse
    @subtitles = []

    chunks = read.split /(\r?\n){2}/
    chunks.each do |chunk|
      chunk.chomp!
      @subtitles << Subtitle.new(chunk) unless chunk.empty?
    end
  end

end
