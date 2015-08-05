class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id]) 
    @favorite_songs = @user.liked_songs.includes(:artist).paginate(page: 1, per_page: 10)
    @favorite_artists = @user.liked_artists.paginate(page: 1, per_page: 10)
    @favorite_albums = @user.liked_albums.includes(:artist).paginate(page: 1, per_page: 8)
    @lyrics_sent = @user.lyrics_sent.includes(:artist).paginate(page: 1, per_page: 10)
    @reviews = @user.reviews.includes(album: :artist)
    @album_ratings = @user.album_ratings.includes(:album).order("score DESC").paginate(page: 1, per_page: 8)
  end

  def liked_artists
    user = User.find(params[:id]) 
    favorite_artists = user.liked_artists.paginate(page: params[:page], per_page: 10)
    render partial: 'liked_artists', locals: {artists: favorite_artists}
  end

  def liked_albums
    user = User.find(params[:id]) 
    favorite_albums = user.liked_albums.includes(:artist).paginate(page: params[:page], per_page: 8)    
    render partial: 'liked_albums', locals: {albums: favorite_albums}
  end

  def liked_songs
    user = User.find(params[:id]) 
    favorite_songs = user.liked_songs.includes(:artist).paginate(page: params[:page], per_page: 10)    
    render partial: 'liked_songs', locals: {songs: favorite_songs}
  end

  def ratings
    user = User.find(params[:id]) 
    album_ratings = user.album_ratings.includes(:album).order("score DESC").paginate(page: params[:page], per_page: 8)
    render partial: 'ratings', locals: {ratings: album_ratings}
  end

  def lyrics_sent
    user = User.find(params[:id]) 
    lyrics_sent = user.lyrics_sent.includes(:artist).paginate(page: params[:page], per_page: 10)
    render partial: 'lyrics_sent', locals: {lyrics_sent: lyrics_sent}
  end
end
