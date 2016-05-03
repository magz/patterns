class Patterns
  attr_accessor :patterns
  def initialize(patterns)
    @patterns = patterns
  end

  #the patterns hash contains nested hashes, with each level of hash representing an element in patterns
  # def patterns_hash
  #   @patterns_hash ||= assemble_hash_tree(patterns)
  # end

  # def assemble_hash_tree(patterns)
  #   result = {}


  #   patterns.each do |pattern|
  #     curent_patterns_hash_position = result
  #     pattern.pattern.slice(0..-2).each do |pattern_element|
  #       curent_patterns_hash_position[pattern_element] ||= {}
  #       curent_patterns_hash_position = curent_patterns_hash_position[pattern_element]
  #     end
  #     curent_patterns_hash_position = pattern
  #   end
  #   result
  # end

  # def improved_match_candidates(path)
    # patterns_hash_paths_to_look_at =
    # path.path.each do |path_elem|
    #   patterns_hash[path_elem]
    # end
  # end

  def best_match(path, strategy=nil)
    # candidates =
    #   if strategy == 'best'
    #     improved_match_candidates(path)
    #   else
    #     quadratitic_match_candidates
    #   end
    # if path.path == %w(a b c)
    #   debugger
    # end
    quadratitic_match_candidates.find {|candidate| candidate.matches?(path)}
  end

  def quadratitic_match_candidates

    @quadratitic_match_candidates ||= patterns.sort {|a,b| b.compare_for_best_match(a)}
  end
end