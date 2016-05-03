class Path
  attr_accessor :path

  def initialize(path_string)
    @path = self.class.parse_path_string(path_string)
  end

  def self.parse_path_string(path_string)
    path_string.split(',')
  end

  def path_length
    path.length
  end
end