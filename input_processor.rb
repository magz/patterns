class InputProcessor
  attr_accessor :path_strings, :pattern_strings
  def initialize(filename)
    raw_file_data = File.open(filename).read
    split_file_data = raw_file_data.split("\n")

    number_of_patterns = split_file_data.first.to_i

    @pattern_strings = split_file_data.slice(1..number_of_patterns)
    @path_strings = split_file_data.slice((number_of_patterns+2)..-1)
  end
end