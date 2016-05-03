require './patterns.rb'
require './pattern.rb'
require './path.rb'
require './input_processor.rb'
require 'ruby-debug'


filepath = ARGV[0]

input_processor = InputProcessor.new(filepath)

pattern_strings = input_processor.pattern_strings
path_strings = input_processor.path_strings

pattern_objects = pattern_strings.map {|ps| Pattern.new(ps)}
pattern_collection = Patterns.new(pattern_objects)

paths = path_strings.map {|ps| Path.new(ps)}

paths.each do |path|
  if best_match = pattern_collection.best_match(path)
   puts best_match.input_string
  else
    puts 'NO MATCH'
  end
end