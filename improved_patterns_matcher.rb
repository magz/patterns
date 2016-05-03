class ImprovedPatternsMatcher
  class TreeNode
    attr_accessor :branch, :leaf
    # def initialize(branch=nil, leaf=nil)
    #   @branch = branch
    #   @leaf = leaf
    # end
  end

  attr_accessor :patterns
  def initialize(patterns)
    @patterns = patterns
  end

  def best_match(path)
    candidates = walk_tree(path.path, patterns_hash).flatten.compact
    candidates.sort {|a,b| b.compare_for_best_match(a)}.first
  end

  def patterns_hash
    @patterns_hash ||= assemble_hash_tree(patterns)
  end

  #so here we're looking to assemble a tree data structure (via nested hashes)
  #where each level represents one character of a pattern
  #terminal leaves are full pattern objects, and non-terminal branches lead to further nested hashes
  def assemble_hash_tree(patterns)
    result = {}


    patterns.each do |pattern|
      curent_patterns_hash_position = result
      pattern.pattern.slice(0..-2).each do |pattern_element|
        #create the fur
        curent_patterns_hash_position[pattern_element] ||= TreeNode.new()
        curent_patterns_hash_position = curent_patterns_hash_position[pattern_element]
      end

      curent_patterns_hash_position[pattern.pattern[-1]] = pattern
    end
    result
  end

  def walk_tree(path, tree)
    if path.length != 0
      walkable_branches = [tree[path.first], tree['*']].compact

      walkable_branches.map do |branch|
        if (path.length != 1) && branch.is_a?(Hash)
          walk_tree(path.slice(1..-1), branch)
        elsif (path.length == 1) && branch.is_a?(Pattern)
          branch
        end
      end
    end
  end


end