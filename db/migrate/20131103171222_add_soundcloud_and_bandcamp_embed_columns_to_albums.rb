class AddSoundcloudAndBandcampEmbedColumnsToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :soundcloud_embed_code, :text
    add_column :albums, :bandcamp_embed_code, :text
  end
end
