class DeviseCreateUsers < ActiveRecord::Migration
  def change
    remove_column :staff, :login
    remove_column :staff, :password
    remove_column :staff, :admin
    remove_column :staff, :permisos

    change_column :staff, :email, :string, :null => "", :default => ""

    rename_table :staff, :users

    change_table(:users) do |t|
      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      t.timestamps
    end

    p "En la BD hay usuarios con el email vacío con lo cual procederemos a borrarlos"
    p "antes de añadir los índices únicos"
    p "===================================="
    execute "DELETE FROM `users` WHERE email = ''"

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end