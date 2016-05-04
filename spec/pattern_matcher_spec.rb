require './pattern_matcher.rb'
require 'spec_helper'
require 'ruby-debug'




RSpec.describe PatternMatcher do
  let(:pattern_matcher) { PatternMatcher.new(filename, strategy) }
  let(:test_output) { ["*,x,y,z", "a,*,*", "*", "NO MATCH", "foo,bar,baz", "a", "*", "ᛥᛥᛥ,foo", "ᛥᛥᛥ,*"] }
  let(:sample_output) { ["*,x,y,z", "a,*,*", "NO MATCH", "NO MATCH", "foo,bar,baz"] }
  let(:test_filename) { 'test_input.txt' }
  let(:sample_filename) { 'sample_input.txt' }

  context 'optimized strategy' do
    let(:strategy) { 'improved' }

    describe 'proceses test_input file' do
      let(:filename) { test_filename }
      it { expect(pattern_matcher.process.output_results).to eq(test_output) }
    end
    describe 'proceses test_input file' do
      let(:filename) { sample_filename }
      it { expect(pattern_matcher.process.output_results).to eq(sample_output) }
    end
  end

  context 'basic strategy' do
    let(:strategy) { 'basic' }

    describe 'proceses test_input file' do
      let(:filename) { test_filename }
      it { expect(pattern_matcher.process.output_results).to eq(test_output) }
    end
    describe 'proceses test_input file' do
      let(:filename) { sample_filename }
      it { expect(pattern_matcher.process.output_results).to eq(sample_output) }
    end
  end

end





