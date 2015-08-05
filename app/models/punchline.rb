class Punchline < ActiveRecord::Base
  extend FriendlyId
  friendly_id :punchline_slug, use: :slugged
  
  attr_accessible :description, :published_at, :online, :lead_in, :album_id, :downloads

  mount_uploader :package, PunchlinePackageUploader

  # Relationships
  belongs_to :album
  has_many :song_files, dependent: :destroy
  has_many :artworks, dependent: :destroy

  # Scopes
  scope :online, where("online = ?", true)
  scope :featured, where(featured: true)
  scope :newest, order("published_at DESC")
  scope :popular, order("downloads DESC")

  def punchline_slug
    "descargar #{album.artist_title_year_slug}"
  end

  def feature!
    Punchline.update_all(featured: false)
    self.update_attribute(:featured, true)
  end

  def package_available?
    self.package.present?
  end

  def package_formatted_file_name
    "#{album.extended_title} [VersosPerfectos.com].zip".gsub(/[\x00\/\\:\*\?\"<>\|]/, '') # Cleanup bad characters for filesystems
  end
end
