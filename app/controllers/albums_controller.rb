class AlbumsController < ApplicationController
  before_filter :authenticate_user!, only: [:vote, :like]

  def index
    query = Album.includes(:artist, :alias)

    if params[:kind] && ['LP', 'CDS', 'MX', 'EP', 'VA', 'CDM'].include?(params[:kind])
      query = query.with_format(params[:kind])
    end

    if params[:year].present? && params[:year].to_i.between?(1980, Time.now.year+2)
      query = query.from_year(params[:year])
    end

    if params[:q].present?
      filter = "%#{params[:q]}%"
      query = query.where("albums.title LIKE :filter OR artists.name LIKE :filter OR aliases.name LIKE :filter", filter: filter)
    end

    @filter_params = params.except(:page)

    @albums = query.paginate :page => params[:page], :per_page => 30
  end

  def show
    @album = Album.find params[:id]
    @liked = false
    @liked = current_user.likes_album?(@album) if user_signed_in?
    @reviews = @album.reviews.order("votes desc, created_at desc")
  end

  def vote
    @album = Album.find params[:id]
    @album.vote(current_user, params[:score])
    @album.update_attribute(:vote_count, @album.album_ratings.count)
    render json: true
  end

  def like
    @album = Album.find params[:id]
    status = @album.switch_like(current_user)
    @album.update_attribute(:fav_count, @album.fans.count)
    render json: {like_status: status, likes_count: @album.fav_count}
  end

  def releases
    if params[:year].present? && params[:week].present?
      @current_week = Date.commercial(params[:year].to_i, params[:week].to_i, 1)
    else
      @current_week = Date.today.at_beginning_of_week
    end

    @next_week = @current_week.next_week
    @previous_week = @current_week - 7.days

    @releases = Album.where(release_date: @current_week..@current_week.end_of_week).order('release_date ASC')
  end
end
