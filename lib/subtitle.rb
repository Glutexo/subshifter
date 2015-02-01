class Subtitle

  def initialize chunk
    chunk.match /^\d+(?<NEWLINE>\r?\n)(?<BEGIN>(?<TIME>\d{2}:\d{2}:\d{2},\d{3})) --> (?<END>\g<TIME>)\k<NEWLINE>(?<BODY>.+)$/m do |match|
      @body = match['BODY']
    end or raise ArgumentError.new "Invalid subtitle chunk: #{chunk}"
  end

end
