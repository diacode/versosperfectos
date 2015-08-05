class SongsController < ApplicationController
  def show
    @song = Song.find params[:id]
  end

  def spotify_player
    song = Song.find params[:id]
    albums = song.albums.where("spotify_identifier IS NOT NULL")
  
    if !albums.empty?
      album_id = albums[0].id

      track = song.tracks.where("album_id = ?", album_id).first
      num_track = track.track_number
      spotify_data = MetaSpotify::Album.lookup("spotify:album:#{albums[0].spotify_identifier}", :extras => "track")
      @spotify_uri = spotify_data.tracks[num_track-1].uri
      render "spotify_embed", :layout => nil
    else
      render "player_not_available", :layout => nil
    end
  end
end
