class Admin::TracksController < ApplicationController  
  before_filter :dashboard_authentication
  layout 'admin'
  
  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    respond_to do |format|
      format.html { redirect_to admin_albums_url }
      format.json { head :no_content }
    end
  end
end
