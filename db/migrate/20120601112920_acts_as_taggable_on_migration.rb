class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    rename_column :tag, :nombre, :name
    rename_column :tag, :permalink, :slug
    rename_table :tag, :tags

    rename_column :tag_noticia, :id_noticia, :taggable_id
    rename_column :tag_noticia, :id_tag, :tag_id

    # Borramos este index que era la antigua clave primaria compuesta por (id_tag, id_noticia)
    execute <<-SQL
        ALTER TABLE tag_noticia DROP PRIMARY KEY
    SQL

    rename_table :tag_noticia, :taggings

    add_column :taggings, :taggable_type, :string, :default => "Post"
    add_column :taggings, :context, :string
    add_column :taggings, :created_at, :datetime

    add_index :taggings, [:taggable_type, :context]

    # Añadimos una clave primaria
    add_column :taggings, :id, :primary_key
  end

end
