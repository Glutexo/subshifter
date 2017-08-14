#!/usr/bin/env ruby

$:.unshift "#{File.dirname(__FILE__)}/lib"
require "subtitle"

begin
  shift = Float(ARGV.shift)
rescue ArgumentError, TypeError
  puts <<-HELP
Usage: subshift.rb <duration> [files]
  <duration> is in seconds and can be decimal.
    Positive number – subtitles will appear later.
    Negative number – subtitles will appear sooner.

Example: ruby subshift.rb -10.7 subtitle.srt
  HELP
  exit
end

subtitle = Subtitle.new $<.read
subtitle.shift! shift

File.write 'shifted.srt', subtitle
