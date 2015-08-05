class AlbumRating < ActiveRecord::Base
  attr_accessible :score, :album_id, :user_id

  belongs_to :album
  belongs_to :user
end
