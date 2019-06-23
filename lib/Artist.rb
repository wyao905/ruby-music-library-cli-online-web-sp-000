class Artist
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self
  end
  
  def add_song(song)
    song.artist = self if song.artist != self
    songs << song if !songs.include?(song)
  end
  
  def genres
    genre_list = []
    songs.each do |song|
      genre_list << song.genre if !genre_list.include?(song.genre)
    end
    genre_list
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.all
    @@all
  end
  
  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end
end