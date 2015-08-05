class Admin::PunchlinesController < ApplicationController
  before_filter :dashboard_authentication
  layout 'admin'

  def index
    @punchlines = Punchline.includes(album: :artist).paginate(:page => params[:page], :per_page => 30)
  end

  def edit
    @punchline = Punchline.find(params[:id])
    @song_files = @punchline.song_files
    @package_generation_available = can_generate_package? 
  end

  def create
    @punchline = Punchline.new(album_id: params[:album_id])

    respond_to do |format|
      if @punchline.save
        format.html { redirect_to edit_admin_punchline_path(@punchline), notice: 'Punchline was successfully created.' }
        format.json { render json: @punchline, status: :created, location: @punchline }
      else
        format.html { render action: "new" }
        format.json { render json: @punchline.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @punchline = Punchline.find(params[:id])

    respond_to do |format|
      if @punchline.update_attributes(params[:punchline])
        format.html { redirect_to admin_punchlines_url, notice: 'El Punchline se actualizo correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @punchline = Punchline.find(params[:id])
    @punchline.destroy

    respond_to do |format|
      format.html { redirect_to admin_punchlines_url, notice: 'El Punchline se borro correctamente.' }
      format.json { head :no_content }
    end
  end

  def upload_file
    file = params[:qqfile]
    punchline = Punchline.find(params[:id])
    album_id = punchline.album_id

    if file.original_filename =~ /.\.mp3$/i
      m = /^([0-9]+)/.match(file.original_filename)

      if !m.nil?
        track_number = m.captures[0].to_i
        track = Track.find(:first, conditions: {track_number: track_number, album_id: album_id})
        
        if !track.nil?
          sf = SongFile.find(:first, conditions: {song_id: track.song_id, punchline_id: punchline.id})  
          
          if sf.nil?
            sf = SongFile.new(song_id: track.song_id, punchline_id: punchline.id)
          end

          sf.audio = file
          sf.save

          render json: {success: true, song_file: sf}
        else
          render json: {success: false, error: "Imposible encontrar la pista #{track_number} en el disco"}
        end
      else
        render json: {success: false, error: "Imposible identificar el numero de la pista"}
      end
    else
      render json: {:success => false, error: "Archivo no valido"} 
    end
  end

  def upload_artwork
    file = params[:qqfile]
    punchline = Punchline.find(params[:id])
    artwork = Artwork.new(punchline_id: params[:id])

    filename = File.basename(file.original_filename, '.*') # Filename without extension
    artwork.art = file
    artwork.title = filename

    if artwork.save
      render json: {success: true, artwork: artwork}
    else
      render json: {success: false, error: 'No se pudo guardar el archivo'}
    end
  end

  def destroy_artwork
    @artwork = Artwork.find(params[:artwork_id])
    @artwork.destroy
    
    respond_to do |format|
      format.html { redirect_to edit_admin_punchline_path(@artwork.punchline_id), notice: 'Artwork borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_song_file
    @song_file = SongFile.find(params[:song_file_id])
    @song_file.destroy
    
    respond_to do |format|
      format.html { redirect_to edit_admin_punchline_path(@song_file.punchline_id), notice: 'Archivo de audio borrado correctamente.' }
      format.json { render json: @song_file }
    end    
  end

  def generate_package
    @punchline = Punchline.find(params[:id])
    if can_generate_package?
      job_id = PunchlineZippedUploadWorker.perform_async(@punchline.id)
      @punchline.update_attribute(:package_job_id, job_id)
      render json: true
    else
      render json: false
    end
  end

  def feature
    @punchline = Punchline.find(params[:id])
    @punchline.feature!
    render json: true
  end

  def package_status
    @punchline = Punchline.find(params[:id])
    render json: {
      status: Sidekiq::Status::status(@punchline.package_job_id),
      message: Sidekiq::Status::message(@punchline.package_job_id),
      package_url: @punchline.package_url
    }
  end

  private

  def can_generate_package?
    @punchline.package_job_id.blank? || 
    [:complete, :failed, nil].include?(Sidekiq::Status::status(@punchline.package_job_id))
  end
end