class MigrateOldComments < ActiveRecord::Migration
  def up
    # Migración para actualizar los antiguos comentarios ya que los IDs de los usuarios están cambiados
    comments = Comment.all

    comments.each do |c|
      puts "Actualizando comentario con ID #{c.id}"
      u = User.find_by_old_forum_id(c.user_id)
      if !u.nil?
        c.user_id = u.id
        c.save
      end
    end
  end

  def down
  end
end
