class RemovePackageRowsFromSongFiles < ActiveRecord::Migration
  def change
    Punchline.all.each do |pl|
      pkg = pl.song_files.where(song_id: nil).first
      
      if !pkg.nil?
        pl.downloads = pkg.downloads
        pl.save
        pkg.destroy
      end
    end
  end
end
