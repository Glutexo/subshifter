#!/usr/bin/env ruby

$:.unshift "#{File.dirname(__FILE__)}/lib"
require "subtitle"

if ARGV[0].nil? or ARGV[1].nil?
  puts 'Usage: subshift.rb <file> <duration>'
  puts '  <duration> is in seconds.'
  puts '    Positive number – subtitles will appear later.'
  puts '    Negative number – subtitles will appear sooner.'
  puts
  puts 'Example: subshift.rb Avatar.srt -10'
  exit
end

source = File.new ARGV[0]
subtitle = Subtitle.new source
subtitle.shift! ARGV[1].to_f

File.write 'shifted.srt', subtitle