class MigrateOldLyricsSenderIds < ActiveRecord::Migration
  def up
    # Migración para actualizar los antiguos comentarios ya que los IDs de los usuarios están cambiados
    songs = Song.where("lyrics_sender_id IS NOT NULL")

    songs.each do |s|
      puts "Actualizando canción con id #{s.id}"
      u = User.find_by_old_forum_id(s.lyrics_sender_id)
      
      if !u.nil?
        s.lyrics_sender_id = u.id
      else
        s.lyrics_sender_id = nil
      end

      s.save
    end
  end

  def down
  end
end
