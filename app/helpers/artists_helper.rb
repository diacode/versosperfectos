module ArtistsHelper
  def artist_fav_class(status)
    "icon_space #{status ? 'liked' : ''}"
  end
end
