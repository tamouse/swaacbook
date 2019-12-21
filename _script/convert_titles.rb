#!/usr/bin/env ruby

# convert file names to markdown links, using the file name to create the title
# e.g. 'miscellaneous-stuff/misc/your-software-is-never-perfect.md' becomes [Your Software Is Never Perfect](miscellaneous-stuff/misc/your-software-is-never-perfect.md)

require "pathname"

def convert_title(s)
  p = Pathname.new(s)
  p
    .basename
    .to_s
    .sub(/\..*?$/, '')
    .sub(/^(\d+-?)+/, '')
    .tr('-', ' ')
    .split
    .map(&:capitalize)
    .join(' ')
end

ARGV.each do |filename|
  puts "[#{convert_title(filename)}](#{filename})"
end
