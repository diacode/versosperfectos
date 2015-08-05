class DestroyTableDestacados < ActiveRecord::Migration
  def change
    drop_table :destacado
  end
end
