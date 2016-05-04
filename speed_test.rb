require './quadratic_patterns_matcher.rb'
require './improved_patterns_matcher.rb'
require './pattern.rb'
require './path.rb'

#this is a very basic speed test that i rigged up, but it confirms that the improved algorithim scales with linear time

path_strings = []
pattern_strings = []
def gen_char
  (65 + rand(26)).chr
end

iterations = ARGV[0].to_i

[[pattern_strings, ','], [path_strings, '/']].each do |test_elems|
  iterations.times do |i|
    result = ''
    rand(4).times do
      x = ''
      rand(3).times do
        x = x + [*gen_char].join(test_elems.last)
      end
      result = result + x
    end
    test_elems.first << result
  end
end

patterns = pattern_strings.map {|ps| Pattern.new(ps) }
paths = path_strings.map {|ps| Path.new(ps) }

matcher = ImprovedPatternsMatcher.new(patterns)
# matcher = QuadraticPatternsMatcher.new(patterns)

start_time = Time.now
paths.each do |path|
  if best_match = matcher.best_match(path)
   puts best_match.input_string
  else
    puts 'NO MATCH'
  end
end
end_time = Time.now
puts (end_time  - start_time)

