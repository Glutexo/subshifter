require 'test/unit'
require 'subtitle'

class SubtitleTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures'

  def setup
    file = File.new "#{FIXTURES_PATH}/subtitle.srt"
    @raw = file.read
    @subtitle = Subtitle.new @raw
  end

  def test_loads_chunks
    chunks = @subtitle.chunks
    assert_instance_of Array, chunks
    assert_equal 3, chunks.length
  end

  def test_can_be_written
    assert_equal @raw, @subtitle.to_s
  end

end