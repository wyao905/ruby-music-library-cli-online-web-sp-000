require 'pry'

class MusicLibraryController
  attr_reader :new_instance, :song_list
  
  def initialize(file_path = "./db/mp3s")
    @new_instance = MusicImporter.new(file_path)
    @song_list = []
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
      case command
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_artist
      when "list genre"
        list_genre
      when "play song"
        play_song
        
      command = gets
    end
  end
  
  def list_songs
    num = new_instance.files.size
    new_instance.files.each {|file| song_list << file.chomp(".mp3").split(" - ")}
    sorted = song_list.sort{|a, b| a[1] <=> b[1]}
    i = 0
    while i < num do
      puts "#{i + 1}. #{sorted[i].join(" - ")}"
      i += 1
    end
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
    input = gets.to_i
    if input > 0 && input <= new_instance.files.size
      new_instance.files.each {|file| song_list << file.chomp(".mp3").split(" - ")}
      sorted = song_list.sort{|a, b| a[1] <=> b[1]}
      puts "Playing #{sorted[input - 1][1]} by #{sorted[input - 1][0]}"
    end
  end
end