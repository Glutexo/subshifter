require 'test/unit'
require 'subtitle'

class SubtitleTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures'

  def setup
    @chunk = Subtitle.new File.new "#{FIXTURES_PATH}/subtitle.srt"
  end

  def test_loads_chunks
    chunks = @chunk.chunks
    assert_instance_of Array, chunks
    assert_equal 3, chunks.length
  end

end