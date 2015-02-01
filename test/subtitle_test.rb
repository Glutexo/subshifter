require 'test/unit'
require 'subtitle'
require 'duration'

class SubtitleTest < Test::Unit::TestCase
  FIXTURE = <<-EOS
1
02:26:23,670 --> 02:26:26,138
"Multiline"
Subtitle Fixture.
  EOS

  def test_body_is_extracted
    subtitle = Subtitle.new FIXTURE
    assert_equal "\"Multiline\"\nSubtitle Fixture.\n", subtitle.body
  end

  def test_begin_time_is_extracted
    subtitle = Subtitle.new FIXTURE
    begin_time = subtitle.begin
    assert begin_time.is_a? Duration

    hours = 2
    minutes = hours * 60 + 26
    seconds = minutes * 60 + 23.670
    assert_equal seconds, begin_time.to_f
  end

  def test_end_time_is_extracted
    subtitle = Subtitle.new FIXTURE
    end_time = subtitle.end
    assert end_time.is_a? Duration

    hours = 2
    minutes = hours * 60 + 26
    seconds = minutes * 60 + 26.138
    assert_equal seconds, end_time.to_f
  end

end