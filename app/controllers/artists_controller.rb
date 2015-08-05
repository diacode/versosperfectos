class ArtistsController < ApplicationController
  before_filter :authenticate_user!, only: [:like]

  def index
    conditions = {}    
    query = Artist

    # Filtrado por nombre
    if params[:q].present?
      filter = "%#{params[:q]}%"
      query = query.includes(:aliases)
                .where("artists.name LIKE :filter OR aliases.name LIKE :filter", filter: filter)
    end

    # Filtrado por inicial
    if params[:initial].present?
      query = query.begin_with(params[:initial])
    end

    # Filtro por especialidad
    if params[:role].present?
      if params[:role] == "mc"
        conditions[:mc] = true
      elsif params[:role] == "producer"
        conditions[:producer] = true
      elsif params[:role] == "dj"
        conditions[:dj] = true
      elsif params[:role] == "director"
        conditions[:clip_director] = true
      end                   
    end

    # Filtro solitario / grupo
    if params[:group].present?
      conditions[:group] = params[:group]
    end

    # Filtro por procedencia (Nacional/Internacional)
    if params[:international].present? && (params[:international] == "0" || params[:international] == "1")
      conditions[:international] = params[:international]
    end

    @filter_params = params.except(:page)
    @artists = query.where(conditions).paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @artist = Artist.find(params[:id])
    @related_posts = Post.tagged_with([@artist.name]).order("published_at DESC").limit(5)
    @discography = @artist.albums.order("year DESC")
    @collabos = @artist.featurings.collaborations.joins(song: {tracks: :album}).order("albums.year DESC").paginate(page: params[:page], per_page: 5)
    @liked = false
    @liked = current_user.likes_artist?(@artist) if user_signed_in?
    
    render "poster"
  end

  def collabos
    @artist = Artist.find(params[:id])
    # TODO: Implementar para usar la paginación de las colabos con AJAX
  end

  def like
    @artist = Artist.find params[:id]
    status = @artist.switch_like(current_user)
    @artist.update_attribute(:fav_count, @artist.fans.count)
    render json: {like_status: status, likes_count: @artist.fav_count}
  end
end
