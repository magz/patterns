require './pattern_matcher.rb'


filepath = ARGV[0]
strategy = ARGV[1]

PatternMatcher.new(filepath, strategy).process.output_results

