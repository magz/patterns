class Pattern
  include Comparable

  attr_accessor :pattern, :input_string

  def initialize(input_string)
    @input_string = input_string
    @pattern = self.class.parse_input_string(input_string)
  end

  def self.parse_input_string(input_string)
    input_string.split(',')
  end

  def matches?(path)
    if path.path_length == pattern_length
      path.path.each_with_index.all? do |path_elem, idx|
        char_matches?(path_elem, pattern[idx])
      end
    else
      false
    end
  end

  #TODO: TEST
  def char_matches?(path_elem, pattern_elem)
    (path_elem == pattern_elem) || (pattern_elem == '*')
  end

  def wildcard_positions
    @wildcard_positions ||= pattern.each_index.select{|i| pattern[i] == '*'}
  end


  def pattern_length
    pattern.length
  end

  #TODO: TEST
  #a quick style note: i normally really dislike multiple return statements in ruby
  #but it actually seemed like the best way to implement this
  def compare_for_best_match(other_pattern)
    if wildcard_positions == other_pattern.wildcard_positions
      return 0
    end

    if wildcard_positions.length != other_pattern.wildcard_positions.length
      return other_pattern.wildcard_positions.length <=> wildcard_positions.length
    end

    paired_wildcards = wildcard_positions.zip(other_pattern.wildcard_positions)
    paired_wildcards.each do |wildcard_position, other_wildcard_position|
      if wildcard_position != other_wildcard_position
        return wildcard_position <=> other_wildcard_position
      end
    end
  end
end






