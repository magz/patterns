#this is the naive implementation of the pattern matching and, as the name implies, works at quadratic time
class QuadraticPatternsMatcher
  attr_accessor :patterns
  def initialize(patterns)
    @patterns = patterns
  end

  def best_match(path)
    quadratitic_match_candidates.find {|candidate| candidate.matches?(path)}
  end

  def quadratitic_match_candidates
    #we use the compare_for_best_match method so that the first match we find is the best one
    @quadratitic_match_candidates ||= patterns.sort {|a,b| a.compare_for_best_match(b)}
  end
end