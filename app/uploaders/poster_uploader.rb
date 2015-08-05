# encoding: utf-8

class PosterUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_and_crop

  protected
    def resize_and_crop
      manipulate! do |img| 
        p "CROP X: #{model.crop_x}"
        p "CROP Y: #{model.crop_y}"
        p "CROP WIDTH: #{model.crop_width}"
        p "CROP HEIGHT: #{model.crop_height}"
        p "REDIM WIDTH: #{model.modified_width}"

        redim_height = (model.modified_width.to_i * img.rows / img.columns).to_i
        p "#{model.modified_width} x #{redim_height}"
        img = img.resize(model.modified_width.to_i, redim_height)
        img = img.crop(model.crop_x.to_i, model.crop_y.to_i, model.crop_width.to_i, model.crop_height.to_i) 
      end 
    end
end
