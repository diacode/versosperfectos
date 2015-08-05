#encoding: utf-8

class PunchlinesController < ApplicationController
  layout 'punchlines'
  before_filter :load_punchline, except: [:index, :list]

  def index
    @most_popular = Punchline.online.popular.joins({album: :artist}).limit(4)
    @newest = Punchline.online.newest.joins({album: :artist}).limit(4)
  end

  def show
    @song_files = @punchline.song_files
  end

  def stream
    sf = SongFile.where(punchline_id: @punchline.id, song_id: params[:song_id]).first
    sf.increment!(:plays)
    redirect_to sf.audio_url
  end

  def download
    sf = SongFile.where(punchline_id: @punchline.id, song_id: params[:song_id]).first
    sf.increment!(:downloads)
    track_number = sf.punchline.album.track_number_for_song(sf.song).to_s.rjust(2, '0')
    redirect_to sf.audio_url(query: {"response-content-disposition" => "attachment;"})
  end

  def download_package
    @punchline.increment!(:downloads)
    redirect_to @punchline.package_url(query: {"response-content-disposition" => "attachment;"})
  end

  def list
    if params[:order] == "newest"
      @punchlines = Punchline.online.newest.joins({album: :artist}).paginate(:page => params[:page], :per_page => 12)
      @header_title = 'Lo último'
    elsif params[:order] == "popular"
      @punchlines = Punchline.online.popular.joins({album: :artist}).paginate(:page => params[:page], :per_page => 12)
      @header_title = 'Lo más popular'
    else
      render_404
    end
  end

  private
    def load_punchline
      @punchline = Punchline.find(params[:id])
    end
end