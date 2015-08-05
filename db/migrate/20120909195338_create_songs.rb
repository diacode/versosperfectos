class CreateSongs < ActiveRecord::Migration
  def change
    rename_column :cancion, :titulo, :title
    rename_column :cancion, :letra, :lyrics
    rename_column :cancion, :fecha_letra, :lyrics_date
    rename_column :cancion, :id_enviador_letra, :lyrics_sender_id
    rename_column :cancion, :id_ultimo_corrector, :lyrics_last_reviser_id
    rename_column :cancion, :enlace_video, :video_link
    rename_column :cancion, :cod_video_embebido, :video_embed_code
    rename_column :cancion, :id_autor, :artist_id
    rename_column :cancion, :fecha_video, :video_date
    rename_column :cancion, :fecha_ultima_correccion, :lyrics_last_revision_date
    rename_column :cancion, :id_validador_letra, :lyrics_validator_id
    rename_column :cancion, :inedito, :unreleased
    rename_column :cancion, :id_enviador_video, :video_sender_id
    rename_column :cancion, :id_validador_video, :video_validator_id
    rename_column :cancion, :permalink, :slug
    rename_column :cancion, :num_favs, :fav_count

    rename_table :cancion, :songs
  end
end
