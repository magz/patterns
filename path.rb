class Path
  attr_accessor :path

  def initialize(input_string)
    @path = self.class.parse_input_string(input_string)
  end

  def self.parse_input_string(input_string)
    if input_string[0] == '/'
      input_string = input_string.slice(1..-1)
    end
    if input_string[-1] == '/'
      input_string = input_string.slice(0..-2)
    end
    input_string.split('/').map(&:to_sym)
  end
end