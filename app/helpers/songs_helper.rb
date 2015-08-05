module SongsHelper
  # Return meta tags for Facebook's Open Graph
  def open_graph_for_song(song)
    capture_haml do
      shared_open_graph_properties
      haml_tag :meta, property: 'og:type', content: 'music.song' 
      haml_tag :meta, property: 'og:title', content: song.permalink
      haml_tag :meta, property: 'og:url', content: song_url(song)
      haml_tag :meta, property: 'og:description', content: first_verse(song)
      haml_tag :meta, property: 'music:musician', content: artist_url(song.artist)
      song.albums.each do |album|
        haml_tag :meta, property: 'og:image', content: album.cover_url
        haml_tag :meta, property: 'music:album', content: album_url(album)
      end
    end
  end

  def first_verse(song)
    song.lyrics.blank? ? '' : song.lyrics.gsub(/(<br\/>)+/, ' / ').truncate(300)
  end
end
