class Artist < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :management
	has_many :aliases
	has_many :albums, :order => "release_date DESC"
  has_many :featurings
  has_many :songs
  has_many :unreleased_songs, :class_name => "Song", :conditions => {:unreleased => true}
  has_many :pictures

  has_and_belongs_to_many :fans, join_table: 'artist_likes', class_name: 'User'

	has_and_belongs_to_many :members, 
		:join_table => :band_memberships, :foreign_key => :group_id, 
		:class_name => "Artist", :association_foreign_key => :member_id

	has_and_belongs_to_many :groups, 
		:join_table => :band_memberships, :foreign_key => :member_id, 
		:class_name => "Artist", :association_foreign_key => :group_id

  accepts_nested_attributes_for :aliases, allow_destroy: true
  accepts_nested_attributes_for :unreleased_songs

  mount_uploader :portrait, PortraitUploader

  default_scope order("artists.name ASC")
  scope :national, where(:international => false)
  scope :international, where(:international => true)
  scope :solo, where(:group => false)
  scope :groups, where(:group => true)
  scope :begin_with, lambda { |initial| where("name LIKE ?", "#{initial}%") }
  scope :having_twitter, where("twitter <> ''")

  def to_s
    name
  end

  def switch_like(user)
    if fans.include?(user)
      fans.delete(user)
      false
    else
      fans << user
      true
    end
  end
end
