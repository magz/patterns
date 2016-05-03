require './pattern.rb'
require './path.rb'
require 'spec_helper'
require 'ruby-debug'




RSpec.describe Pattern do
  describe '.parse_pattern_string' do
    it 'works without leading or trailing slash' do
      expect(Pattern.parse_pattern_string('x/y/xyz/123/🐘🐘🐘')).to eq(['x', 'y', 'xyz', '123', '🐘🐘🐘'])
    end
    it 'works with leading slash' do
      expect(Pattern.parse_pattern_string('/x/y')).to eq(['x', 'y'])
    end
    it 'works with trailing slash' do
      expect(Pattern.parse_pattern_string('x/y/')).to eq(['x', 'y'])
    end
  end
  describe '#matches?' do
    let(:pattern) { Pattern.new('x/y') }
    let(:path) { Path.new('x,y') }
    it 'matches if path and pattern match without wildcards' do
      pattern = Pattern.new('x/y/123')
      path = Path.new('x,y,123')
      expect(pattern.matches?(path)).to eq(true)
    end
    it 'matches with wildcards' do
      pattern = Pattern.new('*/ʥ/*')
      path = Path.new('🐘🐘🐘,ʥ,ψ')
      expect(pattern.matches?(path)).to eq(true)
    end
    it "doesn't match with wildcards and nonmatches" do
      pattern = Pattern.new('*/ʥ/*')
      path = Path.new('🐘🐘🐘,🐘,ψ')
      expect(pattern.matches?(path)).to eq(false)
    end
    it 'matches on unicode characters' do
      pattern = Pattern.new('🐘🐘🐘/ʥ/ψ')
      path = Path.new('🐘🐘🐘,ʥ,ψ')
      expect(pattern.matches?(path)).to eq(true)
    end
    it "doesn't match if unequal" do
      pattern = Pattern.new('x/y')
      path = Path.new('x,a')
      expect(pattern.matches?(path)).to eq(false)
    end
    it "doesn't match if lengths are unequal" do
      pattern = Pattern.new('x/y')
      path = Path.new('x,y,3')
      expect(pattern.matches?(path)).to eq(false)
    end
  end

  describe '#wildcard_positions' do
    it 'works with no wildcards' do
       pattern = Pattern.new('x/yx/yx/yx/yx/yx/yx/y')
       expect(pattern.wildcard_positions).to eq([])
    end
    it 'works with multiple wildcards' do
       pattern = Pattern.new('x/*/yx/*/yx/yx/*/y')
       expect(pattern.wildcard_positions).to eq([1, 3, 6])
    end
  end

  describe '#<=>' do
    it 'works when difference on first position' do
      better_pattern = Pattern.new('x/*')
      worse_pattern = Pattern.new('*/y')
      expect(better_pattern.compare_for_best_match(worse_pattern)).to eq(-1)
    end
    it 'works when difference on second position' do
      better_pattern = Pattern.new('*/y/z/*')
      worse_pattern = Pattern.new('*/y/*/z')
      expect(better_pattern.compare_for_best_match(worse_pattern)).to eq(-1)
    end
    it 'works when difference on third position' do
      better_pattern = Pattern.new('*/y/*/z/y/f/*')
      worse_pattern = Pattern.new('*/y/*/z/y/*/*')
      expect(better_pattern.compare_for_best_match(worse_pattern)).to eq(-1)
    end
    it 'works when bettern pattern has no wildcards' do
      better_pattern = Pattern.new('x/y')
      worse_pattern = Pattern.new('*/y')
      expect(better_pattern.compare_for_best_match(worse_pattern)).to eq(-1)
    end
    it 'works when patterns are equal' do
      better_pattern = Pattern.new('x/y')
      worse_pattern = Pattern.new('x/y')
      expect(better_pattern.compare_for_best_match(worse_pattern)).to eq(0)
    end
  end
end





