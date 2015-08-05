class FormatLyrics < ActiveRecord::Migration
  def up
    songs = Song.where("lyrics IS NOT NULL or lyrics NOT LIKE ?", "")
    
    songs.each do |sng|
      sng.lyrics = sng.lyrics.gsub("\r\n","<br/>")
      sng.save
    end
  end

  def down
  end
end
