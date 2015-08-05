class RecordLabel < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :albums, :dependent => :nullify, :order => "release_date DESC"

  mount_uploader :logo, LogoUploader

  scope :national, where(:international => false)
  scope :international, where(:international => true)
end
