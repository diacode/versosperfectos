class RenameFormacionTable < ActiveRecord::Migration
  def change
  	rename_column :formacion, :id_grupo, :group_id
  	rename_column :formacion, :id_miembro, :member_id
  	rename_table :formacion, :band_memberships
  end
end
