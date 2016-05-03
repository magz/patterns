class Patterns
  attr_accessor :patterns
  def initialize(patterns)
    @patterns = patterns
  end

  def best_match(path)
    match_candidates(path).find {|candidate| candidate.matches?(path)}
  end

  def match_candidates(path)
    patterns.sort {|a,b| b.compare_for_best_match(a)}
  end
end