class Song
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, song_artist = nil, song_genre = nil)
    @name = name
    self.artist = song_artist
    self.genre = song_genre
  end
  
  def artist=(song_artist)
    @artist = song_artist
    song_artist.add_song(self) if song_artist != nil
  end
  
  def genre=(song_genre)
    @genre = song_genre
    if song_genre != nil
      song_genre.songs << self if !song_genre.songs.include?(self)
    end
    @genre
  end
  
  def save
    @@all << self
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.all
    @@all
  end
  
  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end
  
  def self.new_from_filename(filename)
    song_info = filename.chomp(".mp3").split(" - ")
    song_artist = Artist.find_or_create_by_name(song_info[0])
    song_genre = Genre.find_or_create_by_name(song_info[2])
    new_song = Song.new(song_info[1], song_artist, song_genre)
  end
  
  def self.create_from_filename(filename)
    new_song = new_from_filename(filename)
    new_song.save
  end
end