class PunchlineZippedUploadWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform(punchline_id)
    @punchline = Punchline.find(punchline_id)
    @song_files = @punchline.song_files
    @artworks = @punchline.artworks

    # Saving all files from S3 on our temporary folder
    cache_punchline_contents

    # Zipping the contents of our temporary folder
    zip_punchline_contents

    # Uploading the zip to S3
    upload_package

    # Mark worker as finished
    mark_as_finished
  end

  def cache_punchline_contents
    at 1, 'Recopilando contenido remoto'

    @song_files.each do |sf|
      sf.audio.cache_stored_file!
      sf.audio.retrieve_from_cache!(sf.audio.cache_name)
    end

    @artworks.each do |aw|
      aw.art.cache_stored_file!
      aw.art.retrieve_from_cache!(aw.art.cache_name)
    end
  end

  def zip_punchline_contents
    at 2, 'Comprimiendo archivos'

    @zipped_package = Tempfile.new('package.zip')

    # This is the tricky part
    # Initialize the temp file as a zip file
    Zip::OutputStream.open(@zipped_package) { |zos| }

    Zip::File.open(@zipped_package.path, Zip::File::CREATE) do |zipfile|
      @song_files.each do |sf|
        zipfile.add(sf.formatted_file_name, sf.audio.path)
      end

      @artworks.each do |aw|
        zipfile.add("artwork/#{aw.formatted_file_name}", aw.art.path)
      end

      zipfile.get_output_stream("Descarga ofrecida por VersosPerfectos.com.txt") { |f| f.puts "Descarga ofrecida por http://VersosPerfectos.com" }
    end
  ensure
    GC.start
  end

  def upload_package
    at 3, 'Subiendo paquete'
    @punchline.package = @zipped_package
    @punchline.save!
  end

  def mark_as_finished
    at 4, 'Subida realizada'
  end
end
