#so this is my improved patterns matcher, which i believe runs in linear time
#the basic strategy is to assemble a tree, where each layer represents a subsequent element of the patterns/paths
#we can then walk through the tree, going through both direct matches and wildcards
#to get a list of all available matches
#we can then use the patterns' sort method to figure out which pattern is the best match
class ImprovedPatternsMatcher
  class TreeNode
    attr_accessor :branches, :leaves
    def initialize
      @branches = {}
      @leaves = {}
    end
  end

  attr_accessor :patterns
  def initialize(patterns)
    @patterns = patterns
  end

  def best_match(path)
    #get all of patterns that match this given pattern
    candidates = walk_tree(path.path, patterns_hash).flatten.compact
    # use the compare_for_best_match to find the method that best meets our fitness requirements
    candidates.sort {|a,b| a.compare_for_best_match(b)}.first
  end

  #we can assemble our patterns hash only once and use it for every path check
  def patterns_hash
    @patterns_hash ||= assemble_hash_tree(patterns)
  end

  #so here we're looking to assemble a tree data structure (via nested hashes)
  #where each level represents one character of a pattern
  #terminal leaves are full pattern objects, and non-terminal branches lead to further nested hashes
  def assemble_hash_tree(patterns)
    result = TreeNode.new

    patterns.each do |pattern|
      curent_patterns_hash_position = result
      #for each element of the pattern before the last we want to populate a branch node
      pattern.pattern.slice(0..-2).each do |pattern_element|
        curent_patterns_hash_position.branches[pattern_element] ||= TreeNode.new
        curent_patterns_hash_position = curent_patterns_hash_position.branches[pattern_element]
      end
      #for the final element of the pattern, we want to leave the pattern object
      curent_patterns_hash_position.leaves[pattern.pattern.last] = pattern
    end
    result
  end

  def walk_tree(path, tree)
    #if we're not on the last element of the path, see if there are any branches we can walk down
    if path.length != 1
      walkable_branches = [tree.branches[path.first], tree.branches[:*]].compact
      walkable_branches.map do |tree|
        #if we have branches we can walk down, use this same method recursively to walk down it
        walk_tree(path.slice(1..-1), tree)
      end
    else
      #if we're on the last element of the path, return any applicable leaves/patterns
      #we don't have to worry about compacting here since we do that all at once in the client method
      [tree.leaves[path.first], tree.leaves[:*]]
    end
  end
end