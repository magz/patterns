class Pattern
  include Comparable

  attr_accessor :pattern

  def initialize(pattern_string)
    @pattern = self.class.parse_pattern_string(pattern_string)
  end

  def self.parse_pattern_string(pattern_string)
    if pattern_string[0] == '/'
      pattern_string = pattern_string.slice(1..-1)
    end
    if pattern_string[-1] == '/'
      pattern_string = pattern_string.slice(0..-2)
    end
    pattern_string.split('/')
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
  def compare_for_best_match(other_pattern)
    other_pattern_wildcard_positions = other_pattern.wildcard_positions

    if wildcard_positions == []
      if other_pattern_wildcard_positions == []
        return 0
      else
        return -1
      end
    end
    wildcard_positions.each_with_index do |wildcard_position, i|
      other_pattern_wildcard_position = other_pattern_wildcard_positions[i]
      if wildcard_position > other_pattern_wildcard_position
        return -1
      elsif wildcard_position < other_pattern_wildcard_position
        return 1
      end
    end
  end



end






