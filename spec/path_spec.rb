require './path.rb'
require 'spec_helper'
require 'ruby-debug'




RSpec.describe Path do
  describe '.parse_input_string' do
    it 'works without leading or trailing slash' do
      expect(Path.parse_input_string('x/y/xyz/123/ᛥᛥᛥ')).to eq(['x', 'y', 'xyz', '123', 'ᛥᛥᛥ'].map(&:to_sym))
    end
    it 'works with leading slash' do
      expect(Path.parse_input_string('/x/y')).to eq(['x', 'y'].map(&:to_sym))
    end
    it 'works with trailing slash' do
      expect(Path.parse_input_string('x/y/')).to eq(['x', 'y'].map(&:to_sym))
    end
  end
end





