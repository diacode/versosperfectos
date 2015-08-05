class DropForeignKeys < ActiveRecord::Migration
  database_name = Rails.configuration.database_configuration[Rails.env]['database']
  foreign_keys = ActiveRecord::Base.connection.execute(
    "SELECT TABLE_NAME, CONSTRAINT_NAME " \
    "FROM information_schema.TABLE_CONSTRAINTS "\
    "WHERE CONSTRAINT_TYPE='FOREIGN KEY' AND TABLE_SCHEMA = '#{database_name}'")

  foreign_keys.each do |fk|
    p "Dropping constraint #{fk[1]} FROM table #{fk[0]}"
    ActiveRecord::Base.connection.execute("ALTER TABLE #{fk[0]} DROP FOREIGN KEY #{fk[1]}")
  end

end