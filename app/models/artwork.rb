class Artwork < ActiveRecord::Base
  attr_accessible :art, :punchline_id, :title

  mount_uploader :art, ArtworkUploader

  # Validations
  validates :title, presence: true

  # Relationships
  belongs_to :punchline

  def formatted_file_name
    extension = File.extname(self.art.path)
    "#{title}#{extension}".gsub(/[\x00\/\\:\*\?\"<>\|]/, '') # Cleanup bad characters for filesystems
  end
end
