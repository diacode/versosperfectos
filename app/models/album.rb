class Album < ActiveRecord::Base  
	extend FriendlyId
  friendly_id :artist_title_year_slug, use: :slugged

	belongs_to :artist
	belongs_to :alias
	belongs_to :inserter, :class_name => "User"
	belongs_to :record_label

	has_many :songs, :through => :tracks
	has_many :tracks, :order => 'track_number ASC'
  has_many :album_ratings
  has_many :voters, through: :album_ratings, source: :user
  has_many :reviews
  has_one :punchline
  has_and_belongs_to_many :fans, join_table: 'album_likes', class_name: 'User'

	mount_uploader :cover, CoverUploader

	# Validaciones
	validates :artist_id, :year, :title, :presence => true
	validates :year, :numericality => { 
		:only_integer => true,
		:greater_than => 1900
	}

	accepts_nested_attributes_for :tracks

  scope :national, joins(:artist).where(:artists => {:international => false})
  scope :international, joins(:artist).where(:artists => {:international => true})
  scope :without_cover, where(cover: nil)
  scope :empty_tracklist, includes(:tracks).where(tracks: {id: nil})
  scope :from_year, lambda { |year| where(year: year) }
  scope :with_format, lambda { |kind| where(format: kind) }
  scope :incoming_releases, lambda { where("release_date >= ?", Date.today).order("release_date ASC") }

  #includes(:tracks).having("count(tracks.id) = 0")

  def to_s
    title
  end

  def title_with_year
    title << (" (#{year})" unless year.blank?)
  end

	def artist_title_year_slug
		"#{effective_artist_name} #{title} #{year}"
	end

	def effective_artist_name
		if self.alias != nil
			self.alias.name
		elsif !artist_id.nil?
			artist.name
		else
			""
		end
	end

  def extended_title
    "#{effective_artist_name} - #{title} (#{year})"
  end

  def add_new_tracks(numbers, titles)
  	numbers.each_with_index do |n, idx|
  		title = titles[idx]

  		song = Song.new(:title => title, :artist_id => self.artist_id)
  		track = Track.new

  		track.album = self
  		track.song = song
  		track.track_number = n

  		self.tracks << track
  	end
  end

  def featured_artists
    fts = []

    songs.each do |sng|
      sng.featurings.collaborations.each do |ft|
        fts.push(ft.artist)
      end
    end

    fts.uniq!

    fts
  end

  def vote(user, score)
    rating = AlbumRating.where(user_id: user.id, album_id: id).first_or_initialize
    rating.score = score
    rating.save
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

  def has_any_streaming?
    spotify_identifier.present? ||
    soundcloud_embed_code.present? ||
    bandcamp_embed_code.present?
  end

  def track_number_for_song(song)
    tracks.where(song_id: song.id).pluck(:track_number).first
  end
end
