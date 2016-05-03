class QuadraticPatternsMatcher
  attr_accessor :patterns
  def initialize(patterns)
    @patterns = patterns
  end

  def best_match(path)
    quadratitic_match_candidates.find {|candidate| candidate.matches?(path)}
  end

  def quadratitic_match_candidates
    @quadratitic_match_candidates ||= patterns.sort {|a,b| a.compare_for_best_match(b)}
  end
end