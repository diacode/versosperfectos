class Song < ActiveRecord::Base
  extend FriendlyId
  friendly_id :permalink, use: :slugged

  belongs_to :artist
  belongs_to :lyrics_sender, :class_name => "User"
  belongs_to :lyrics_last_reviser, :class_name => "User"
  belongs_to :lyrics_validator, :class_name => "User"
  belongs_to :video_sender, :class_name => "User"
  belongs_to :video_validator, :class_name => "User"

  has_many :albums, :through => :tracks
  has_many :tracks, :dependent => :delete_all
  has_many :featurings, :dependent => :delete_all

  has_and_belongs_to_many :fans, join_table: 'song_likes', class_name: 'User'

  accepts_nested_attributes_for :featurings, allow_destroy: true

  scope :having_clip, where("(video_link IS NOT NULL AND video_link <> ?) OR (video_embed_code IS NOT NULL AND video_embed_code <> ?)" , '', '')
  scope :last_lyrics, order("lyrics_date DESC")

  # Hooks
  before_save :update_lyrics_date
  before_save :update_video_date

  def permalink
    "#{artist.name} - #{title}"
  end

  def minimized
    {
      :id => self.id,
      :title => self.title,
      :artist => {
        :id => self.artist_id,
        :name => self.artist.name
      }
    }
  end

  def producers
    producers = []

    featurings.each do |ft|
      if ft.producer
        producers.push ft.artist
      end
    end

    producers
  end

  def has_spotify_embed?
    albums.where("spotify_identifier IS NOT NULL").count > 0
  end

  private
    def update_lyrics_date
      self.lyrics_date = DateTime.now if !lyrics.blank? && lyrics_was.blank?
    end

    def update_video_date
      self.video_date = DateTime.now if (!video_link.blank? || !video_embed_code.blank?) && (video_link_was.blank? && video_embed_code_was.blank?)
    end
end
