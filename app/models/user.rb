class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin, :staff, :displayname,
    :old_forum_id, :created_at, :provider, :uid, :avatar, :remote_avatar_url, :remove_avatar

  mount_uploader :avatar, AvatarUploader

  # Scopes
  scope :staff, where(staff: true)
  scope :admins, where(admin: true)
  scope :most_active, order("comments_count DESC")

  # Relations
  has_many :posts, :foreign_key => :poster_id
  has_many :inserted_albums, :class_name => "Album", :foreign_key => :inserter_id
  has_many :comments
  has_many :album_ratings
  has_many :reviews, foreign_key: 'author_id'
  has_and_belongs_to_many :liked_albums, join_table: 'album_likes', class_name: 'Album' 
  has_and_belongs_to_many :liked_artists, join_table: 'artist_likes', class_name: 'Artist' 
  has_and_belongs_to_many :liked_songs, join_table: 'song_likes', class_name: 'Song'
  has_many :lyrics_sent, class_name: 'Song', foreign_key: 'lyrics_sender_id'

  # Validations
  validates :displayname, :presence => true

  def to_s
    displayname || email
  end

  def belongs_to_staff?
  	if staff == true || admin == true
  		return true
  	else
  		return false
  	end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    # user = User.where(:provider => auth.provider, :uid => auth.uid).first
    user = User.where(:email => auth.info.email).first
    
    unless user
      user = User.create(displayname:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                        )
    end

    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def likes_album?(album)
    liked_albums.include?(album)
  end

  def likes_artist?(artist)
    liked_artists.include?(artist)
  end
end
