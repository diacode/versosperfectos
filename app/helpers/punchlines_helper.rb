module PunchlinesHelper
  def song_file_for_song(song_id, song_files)
    song_files.select { |e| e.song_id == song_id }.first
  end
end