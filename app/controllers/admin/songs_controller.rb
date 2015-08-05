#encoding: utf-8

class Admin::SongsController < ApplicationController  
  before_filter :dashboard_authentication
  layout 'admin'

  def search
    @songs = Song.joins(:artist).where("title LIKE ? AND artists.name LIKE ?", "%#{params[:title]}%", "%#{params[:artist]}%").limit(10)

    respond_to do |format|
      # TODO incluir en el json el nombre del artista y quitar la letra del renderizado
      format.json { 
        render json: @songs.collect { |sng| sng.minimized }.to_json
      }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end
 
  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to admin_albums_url, notice: 'La canción se actualizó correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to admin_albums_url }
      format.json { head :no_content }
    end
  end
end
