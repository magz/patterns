require './path.rb'
require 'spec_helper'
require 'ruby-debug'




RSpec.describe Path do
  describe '.parse_path_string' do
    it do
      expect(Path.parse_path_string('x,y,123,🐘🐘🐘')).to eq(['x', 'y', '123', '🐘🐘🐘'])
    end
  end
end





