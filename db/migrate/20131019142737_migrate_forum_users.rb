class MigrateForumUsers < ActiveRecord::Migration
  def up
    # TODO: Agregar al SQL un filtro para excluir a los usuarios inactivos o que no hayan entrado nunca

    # Parte del procedimiento para asignar a los usuarios del staff que ya están previamente importados
    # su ID del foro.    
    user_ids = [3, 4, 6, 18, 22, 23, 24, 25]
    old_forum_ids = [1, 2, 4, 11450, 20, 2173, 97, 6321]

    user_ids.each_with_index do |uid, idx|
      u = User.find_by_id uid
      
      if !u.nil?
        u.old_forum_id = old_forum_ids[idx]
        u.save
      end
    end

    # A continuación importamos todos los foro members a User salvo los que ya están precargados, es decir, los anteriores.
    old_forum_users = ActiveRecord::Base.connection.execute("SELECT ID_MEMBER, emailAddress, memberName, dateRegistered FROM foro_members WHERE ID_MEMBER NOT IN (#{old_forum_ids.join(',')})")
    
    old_forum_users.each do |ofu|
      member_id = ofu[0]
      email = ofu[1]
      displayname = ofu[2]
      created_at = Time.at(ofu[3])

      puts "Importando al usuario #{displayname} con el email #{email}"

      u = User.new(:old_forum_id => member_id, :email => email, :displayname => displayname, :created_at => created_at)
      u.password_confirmation = u.password = Devise.friendly_token[0,20]
      u.save
    end
  end

  def down
  end
end
