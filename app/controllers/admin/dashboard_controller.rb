class Admin::DashboardController < ApplicationController
	before_filter :dashboard_authentication
	layout 'admin'

  def index
    # Artistas
    @national_artists = Artist.national.count
    @international_artists = Artist.international.count
    @total_artists = @national_artists + @international_artists

    # Albums
    @national_albums = Album.national.count
    @international_albums = Album.international.count
    @total_albums = @national_albums + @international_albums
  
    # Sellos
    @national_labels = RecordLabel.national.count
    @international_labels = RecordLabel.international.count
    @total_labels = @national_labels + @international_labels

    # Usuarios
    @total_users = User.count
    @admins = User.admins.count
    @staff = User.staff.count

    @posts = Post.count
    @comments = Comment.count
  end
end
