require 'pry'

class MusicLibraryController
  attr_reader :new_instance
  
  def initialize(file_path = "./db/mp3s")
    @new_instance = MusicImporter.new(file_path)
    new_instance.import
  end
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    
    command = gets
    while command != "exit" do
      command = gets
    end
  end
  
  def list_songs
    num = new_instance.files.size
    list = []
    new_instance.files.each {|file| list << file.chomp(".mp3").split(" - ")}
    sorted = list.sort{|a, b| a[1] <=> b[1]}
    i = 0
    while i < num do
      list[i] = "#{i + 1}. #{sorted[i].join(" - ")}"
      puts "#{i + 1}. #{sorted[i].join(" - ")}"
      i += 1
    end
    list
  end
  
  def list_artists
    num = Artist.all.size
    list = []
    Artist.all.each {|artist| list << artist.name}
    sorted = list.sort
    i = 0
    while i < num do
      puts "#{i + 1}. #{sorted[i]}"
      i += 1
    end
  end
    
  def list_genres
    num = Genre.all.size
    list = []
    Genre.all.each {|genre| list << genre.name}
    sorted = list.sort
    i = 0
    while i < num do
      puts "#{i + 1}. #{sorted[i]}"
      i += 1
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if artist = Artist.find_by_name(input)
      artist.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
        puts "#{i}. #{s.name} - #{s.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if genre = Genre.find_by_name(input)
      genre.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip
    puts "Playing #{list_songs[input.to_i - 1]}"
    binding.pry
  end
end