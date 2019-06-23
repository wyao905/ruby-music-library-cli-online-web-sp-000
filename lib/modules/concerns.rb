module Concerns
  module Findable
    def find_by_name(song_name)
      all.each {|song| return song if song.name == song_name}
    end
  
    def find_or_create_by_name(name)
      if !all.include?(find_by_name(name))
        found_song = create(name)
      else
        find_by_name(name)
      end
    end
  end
end