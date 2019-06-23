class MusicImporter
  attr_accessor :path
  
  def initialize(file_path)
    @path = file_path
  end
  
  def files
    normal = []
    Dir["#{path}/*"].each {|file| normal << file.reverse.chomp("/#{@path.reverse}").reverse}
    return normal
  end
end