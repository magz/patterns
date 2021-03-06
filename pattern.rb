class Pattern
  attr_accessor :pattern, :input_string

  def initialize(input_string)
    @input_string = input_string
    @pattern = self.class.parse_input_string(input_string)
  end

  def self.parse_input_string(input_string)
    input_string.split(',').map(&:to_sym)
  end

  def matches?(path)
    if path.path.length == pattern.length
      path.path.each_with_index.all? do |path_elem, idx|
        char_matches?(path_elem, pattern[idx])
      end
    else
      false
    end
  end

  #i used this strategy rather than assembling a regex because i didn't want, for example,
  #aaa/b to match a,a,a,b....it's possible there's a way to make regex work for this, but since
  #this was the slower strategy to begin with, i decided not to get into that
  def char_matches?(path_elem, pattern_elem)
    (path_elem == pattern_elem) || (pattern_elem == :*)
  end

  def wildcard_positions
    @wildcard_positions ||= pattern.each_index.select{|i| pattern[i] == :*}
  end

  #a quick style note: i normally really dislike multiple return statements in ruby
  #but it actually seemed like the best way to implement this
  #if we wanted to be really fancy here we could define this as <=> and Comparable
  #and be able to just straight do collection.sort, but i thought that was a little bit too Black Magic :)
  def compare_for_best_match(other_pattern)
    #i dont think this should ever actually come up, but put it in to make this more flexible
    if wildcard_positions == other_pattern.wildcard_positions
      #0 means equality to rubys sort method
      return 0
    end

    #check to see if one has more wildcards
    if wildcard_positions.length != other_pattern.wildcard_positions.length
      #the spaceship operator returns -1 if first is less, 1 if it's more, 0 if they're equal
      return wildcard_positions.length <=> other_pattern.wildcard_positions.length
    end

    #since we knwo they each
    paired_wildcards = wildcard_positions.zip(other_pattern.wildcard_positions)
    paired_wildcards.each do |wildcard_position, other_wildcard_position|
      if wildcard_position != other_wildcard_position
        return other_wildcard_position <=> wildcard_position
      end
    end
  end
end






