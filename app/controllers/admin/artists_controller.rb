class Admin::ArtistsController < ApplicationController
  before_filter :dashboard_authentication
  layout 'admin'

  # GET /admin/artists
  # GET /admin/artists.json
  def index
    if !params[:q]
      @artists = Artist.paginate(:page => params[:page], :per_page => 30).order("name")
    else
      @artists = Artist.where("name LIKE ?", "%#{params[:q]}%").paginate(:page => params[:page], :per_page => 30).order("name")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artists }
    end
  end

  # GET /admin/artists/1
  # GET /admin/artists/1.json
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /admin/artists/new
  # GET /admin/artists/new.json
  def new
    @artist = Artist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /admin/artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end

  # POST /admin/artists
  # POST /admin/artists.json
  def create
    params[:artist][:group_ids] = [] if params[:artist][:group_ids] == nil
    params[:artist][:member_ids] = [] if params[:artist][:member_ids] == nil

    @artist = Artist.new(params[:artist])

    respond_to do |format|
      if @artist.save
        format.html { redirect_to admin_artists_url, notice: 'Artista creado correctamente.' }
        format.json { render json: @artist, status: :created, location: @artist }
      else
        format.html { render action: "new" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/artists/1
  # PUT /admin/artists/1.json
  def update    
    params[:artist][:group_ids] = [] if params[:artist][:group_ids] == nil
    params[:artist][:member_ids] = [] if params[:artist][:member_ids] == nil

    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to admin_artists_url, notice: 'Artista actualizado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/artists/1
  # DELETE /admin/artists/1.json
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to admin_artists_url }
      format.json { head :no_content }
    end
  end

  def upload_picture
    file = params[:qqfile] # AppSpecificStringIO.new(params[:qqfile], request.raw_post)
    @pic = Picture.new(:artist_id => params[:artist_id], :image => file)

    respond_to do |format|
      if @pic.save
        format.json { render json: {:success => true, picture: @pic} }
      else
        format.json { render json: {:success => false, error: @pic.errors[:image][0] } }
      end
    end
  end

  def twitter_lookup
    @artist = Artist.having_twitter.where("name LIKE ?", "%#{params[:q]}%").first
    respond_to do |format|
      format.json { render json: @artist }
    end
  end

  def aliases
    @aliases = Alias.where(artist_id: params[:id])

    respond_to do |format|
      format.json { render json: @aliases }
    end
  end
end
