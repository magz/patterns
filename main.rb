require './quadratic_patterns_matcher.rb'
require './improved_patterns_matcher.rb'
require './pattern.rb'
require './path.rb'
require './input_processor.rb'
require 'ruby-debug'


filepath = ARGV[0]

input_processor = InputProcessor.new(filepath)

pattern_strings = input_processor.pattern_strings
path_strings = input_processor.path_strings

pattern_objects = pattern_strings.map {|ps| Pattern.new(ps)}
quadratic_patterns_collection = QuadraticPatternsMatcher.new(pattern_objects)
improved_patterns_collection = ImprovedPatternsMatcher.new(pattern_objects)

paths = path_strings.map {|ps| Path.new(ps)}


puts "QUADRATIC IMPLEMENTATION"
paths.each do |path|
  if best_match = quadratic_patterns_collection.best_match(path)
   puts best_match.input_string
  else
    puts 'NO MATCH'
  end
end

puts "IMPROVED IMPLEMENTATION"
paths.each do |path|
  if best_match = improved_patterns_collection.best_match(path)
   puts best_match.input_string
  else
    puts 'NO MATCH'
  end
end