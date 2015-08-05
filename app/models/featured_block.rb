class FeaturedBlock < ActiveRecord::Base
  attr_accessor :crop_width, :crop_height, :crop_x, :crop_y, :modified_width
  attr_accessible :link, :poster, :slot, :title,
    # Virtual attributes for redim and crop purposes
    :crop_width, :crop_height, :crop_x, :crop_y, :modified_width

  mount_uploader :poster, PosterUploader

  def self.dimensions(slot)
    if slot == 0
      {width: 340, height: 350}
    else
      {width: 342, height: 175}
    end
  end
end
