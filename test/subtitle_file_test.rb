require 'test/unit'
require 'subtitle_file'

class SubtitleFileTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

  def test_extends_file
    file = SubtitleFile.new(FIXTURES_PATH + 'subtitle.srt')
    assert file.is_a? File
  end

end