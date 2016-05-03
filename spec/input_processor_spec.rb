require './input_processor.rb'
require 'spec_helper'
require 'ruby-debug'




RSpec.describe InputProcessor do
  let(:filename) { 'test_input.txt' }
  let(:processor) { InputProcessor.new(filename) }

  context 'sample_input' do
    let(:filename) { 'sample_input.txt' }

    it '#initialize' do
      expect(processor.pattern_strings).to eq(["*,b,*", "a,*,*", "*,*,c", "foo,bar,baz", "w,x,*,*", "*,x,y,z"])
      expect(processor.path_strings).to eq(["/w/x/y/z/", "a/b/c", "foo/", "foo/bar/", "foo/bar/baz/"])
    end
  end
  context 'sample_input' do
    let(:filename) { 'test_input.txt' }

    it '#initialize' do
      expect(processor.pattern_strings).to eq([
        "*,b,*",
        "a,*,*",
        "*,*,c",
        "foo,bar,baz",
        "w,x,*,*",
        "*,x,y,z",
        "*",
        "a",
        "ᛥᛥᛥ,*",
        "ᛥᛥᛥ,foo"])

      expect(processor.path_strings).to eq([
        "/w/x/y/z/",
        "a/b/c",
        "foo/",
        "foo/bar/",
        "/foo/bar/baz/",
        "a",
        "*",
        "/ᛥᛥᛥ/foo/",
        "/ᛥᛥᛥ/123/"])
    end
  end

end