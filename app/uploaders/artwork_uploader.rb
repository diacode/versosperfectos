# encoding: utf-8

class ArtworkUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/punchlines/#{model.punchline_id}/artwork"
  end

  def filename
    model.formatted_file_name
  end
end
