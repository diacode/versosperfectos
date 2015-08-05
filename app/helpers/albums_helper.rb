#encoding=utf-8
module AlbumsHelper
  def album_fav_class(status)
    "fav #{status ? 'liked' : ''}"
  end

  def album_embed_streaming(album)
    if album.spotify_identifier.present?
      %{<iframe src="https://embed.spotify.com/?uri=spotify:album:#{album.spotify_identifier}" width="300" height="80" frameborder="0" allowtransparency="true" class="spotify_mini_player"></iframe>}
    elsif album.soundcloud_embed_code.present?
      album.soundcloud_embed_code
    elsif album.bandcamp_embed_code.present?
      album.bandcamp_embed_code
    end       
  end

  def open_graph_for_album(album)
    capture_haml do
      shared_open_graph_properties
      haml_tag :meta, property: 'og:type', content: 'music.album' 
      haml_tag :meta, property: 'og:title', content: album.title
      haml_tag :meta, property: 'og:url', content: album_url(album)
      haml_tag :meta, property: 'og:description', content: album_description(album)
      # haml_tag :meta, property: 'og:image', content: image_url(album.cover_url.to_s)
      haml_tag :meta, property: 'music:musician', content: artist_url(album.artist)
      haml_tag :meta, property: 'music:release_date', content: album.release_date.iso8601 unless album.release_date.blank?
      # Tracklist for FB
      album.tracks.each do |track|
        haml_tag :meta, property: 'music:song', content: song_url(track.song)
        haml_tag :meta, property: 'music:song:track', content: track.track_number
      end
    end
  end

  def album_description(album)
    description = "Disco: #{album.title}, Autor: #{album.artist.name}"
    description += ". Año: #{album.year}" unless album.year.blank?
    description += ". Música: Hip-Hop"
    description += ". Sello: #{album.record_label.name}" unless album.record_label.blank?
    description += ". Tipo: #{album.format}" unless album.format.blank?
    description += ". Fecha lanzamiento: #{l album.release_date}" unless album.release_date.blank?
    description
  end
end
