class SongFile < ActiveRecord::Base
  attr_accessible :song_id, :downloads, :punchline_id, :plays, :audio

  belongs_to :song
  belongs_to :punchline

  mount_uploader :audio, AudioUploader

  def formatted_file_name
    album = self.punchline.album
    song = self.song
    num_track = album.track_number_for_song(song).to_s.rjust(2, '0')
    extension = File.extname(self.audio.path)
    filename = "#{num_track} - #{album.effective_artist_name} - #{song.title} [VersosPerfectos.com]#{extension}"
    filename.gsub(/[\x00\/\\:\*\?\"<>\|]/, '') # Based on http://stackoverflow.com/questions/2270635/invalid-chars-filter-for-file-folder-name-ruby
  end
end
