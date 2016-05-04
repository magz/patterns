require './quadratic_patterns_matcher.rb'
require './improved_patterns_matcher.rb'
require './pattern.rb'
require './path.rb'
require './input_processor.rb'
require 'ruby-debug'

class PatternMatcher
  def initialize(filepath, strategy='improved')
    @filepath = filepath
    @strategy = strategy
  end

  def process
    input_processor = InputProcessor.new(@filepath)

    pattern_strings = input_processor.pattern_strings
    path_strings = input_processor.path_strings

    pattern_objects = pattern_strings.map {|ps| Pattern.new(ps)}
    path_objects = path_strings.map {|ps| Path.new(ps)}


    matcher =
      if @strategy == 'improved'
        ImprovedPatternsMatcher.new(pattern_objects)
      else
        QuadraticPatternsMatcher.new(pattern_objects)
      end
    @output_strings = get_output_strings(matcher, path_objects)
    self
  end

  def output_results
    @output_strings.each {|output| puts output}
  end

  def get_output_strings(matcher, paths)
    paths.map do |path|
      if best_match = matcher.best_match(path)
       best_match.input_string
      else
        'NO MATCH'
      end
    end
  end
end

