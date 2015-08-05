class Picture < ActiveRecord::Base
  attr_accessible :image, :artist_id
  attr_accessor :image_upload_width, :image_upload_height

  belongs_to :artist

  mount_uploader :image, ImageUploader

  validate :image, :presence => true
  validate :validate_minimum_image_size

  def validate_minimum_image_size
    unless image_upload_width > 1022 && image_upload_height > 575
      errors.add :image, "La resolucion minima es 1022x575" 
    end
  end
end
