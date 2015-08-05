# encoding: utf-8

class PunchlinePackageUploader < CarrierWave::Uploader::Base
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/punchlines/#{model.id}"
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    model.package_formatted_file_name
  end
end
