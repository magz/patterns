require './pattern_matcher.rb'
require 'ruby-debug'

filepath = ARGV[0]
strategy = ARGV[1]

PatternMatcher.new(filepath, strategy).process.output_results

