class InputProcessor
  attr_accessor :path_strings, :pattern_strings
  def initialize(filename)
    input_text = File.open(filename).read.split("\n")

    number_of_patterns = input_text.first.to_i

    @pattern_strings = input_text.slice(1..number_of_patterns)
    @path_strings = input_text.slice((number_of_patterns+2)..-1)
  end
end