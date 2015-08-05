class Featuring < ActiveRecord::Base
  belongs_to :song
  belongs_to :artist

  scope :collaborations, where("collaboration = ?", true)
end
