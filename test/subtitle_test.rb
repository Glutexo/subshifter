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

  def test_can_be_shifted
    shift = 12.34

    chunks = @subtitle.chunks.map { |chunk| chunk.shift shift }
    shifted = Subtitle.new chunks

    assert_equal shifted.to_s, @subtitle.shift(shift).to_s
    assert_equal @raw, @subtitle.to_s
  end

  def test_can_be_duplicated
    subtitle = @subtitle.dup

    assert_equal subtitle.to_s, @subtitle.to_s
    assert_not_same subtitle, @subtitle

    first_chunk = @subtitle.chunks.first
    dup_first_chunk = subtitle.chunks.first
    assert_equal dup_first_chunk.to_s, first_chunk.to_s
    assert_not_same dup_first_chunk, first_chunk
  end

  def test_can_be_shifted_in_place
    shift = 12.34

    chunks = @subtitle.chunks.map { |chunk| chunk.shift shift }
    shifted = Subtitle.new chunks

    subtitle = @subtitle.dup
    subtitle.shift! shift

    assert_equal shifted.to_s, subtitle.to_s
    assert_not_same shifted, subtitle
    assert_equal @raw, @subtitle.to_s
    assert_not_same subtitle, @subtitle
  end

end