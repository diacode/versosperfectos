class Admin::AlbumsController < ApplicationController
  before_filter :dashboard_authentication
  layout 'admin'

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.includes(:artist).joins(:artist)

    # Filtrado de campos
    if !params[:q].blank?
      filter = "%#{params[:q]}%"
      @albums = @albums.where("title LIKE ? OR artists.name LIKE ?", filter, filter).paginate(:page => params[:page], :per_page => 30)
    end

    @albums = @albums.without_cover if params[:no_cover].present?
    @albums = @albums.empty_tracklist if params[:empty_tracklist].present?
    
    # Paginación
    @albums = @albums.paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new
    @alias_choices = []

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
    @alias_choices = @album.artist.aliases
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])
    @album.add_new_tracks(params[:new_tracks_number], params[:new_tracks_title]) if params[:new_tracks_number]

    respond_to do |format|
      if @album.save
        format.html { redirect_to [:admin, @album], notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])
    @album.add_new_tracks(params[:new_tracks_number], params[:new_tracks_title]) if params[:new_tracks_number]

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to admin_albums_url, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to admin_albums_url }
      format.json { head :no_content }
    end
  end

  def massive_association
    song_ids = params[:song_ids].split(",")
    artist_id = params[:artist_id]

    song_ids.each do |song_id|
      feat_data = {song_id: song_id, artist_id: artist_id}
      feat = Featuring.find(:first, conditions: feat_data) || Featuring.new(feat_data)
      feat.collaboration = params[:collaboration] || false
      feat.mc = params[:mc] || false
      feat.producer = params[:producer] || false
      feat.dj = params[:dj] || false
      feat.clip_director = params[:clip_director] || false
      feat.save
    end

    render json: true
  end
end
