class AddAudioLinkColumnToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :audio_link, :string
  end
end
