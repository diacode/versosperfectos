class Track < ActiveRecord::Base
  belongs_to :song
  belongs_to :album
end
