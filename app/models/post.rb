require 'nokogiri'

class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  searchkick language: 'Spanish'
  
  attr_accessible :draft, :title, :content, :tag_list, :flag_twitter, :flag_facebook, :twitter_message, :category_ids, :published_at_date, :published_at_time

  # Virtual attributes and casting for boolean behaviour
  attr_accessor :twitter_message, :published_at_date, :published_at_time
  attr_reader :flag_twitter, :flag_facebook

  ITEMS_PER_PAGE = 10
  
  def flag_twitter=(value)
    @flag_twitter = ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
  end

  def flag_facebook=(value)
    @flag_facebook = ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
  end
  
  delegate :url_helpers, to: 'Rails.application.routes'
  acts_as_taggable

  # Relationships
  has_many :comments
  has_and_belongs_to_many :categories
  belongs_to :creator, :class_name => 'User', :foreign_key => :poster_id
  belongs_to :last_editor, :class_name => 'User', :foreign_key => :last_editor_id

  # Scopes
  default_scope order("published_at DESC")
  scope :published, where(:draft => false)
  scope :current_week, where("published_at >= ? AND published_at <= ?", DateTime.now.beginning_of_week, DateTime.now.end_of_week)
  scope :by_category, lambda { |category_id|
    joins(:categories)
    .where("categories.id = ?", category_id)
  }

  # Callbacks
  after_save :share_in_twitter, if: :post_in_twitter?
  after_save :share_in_facebook, if: :post_in_facebook?
  after_initialize :get_datetimes # convert db format to accessors
  before_validation :set_datetimes # convert accessors back to db format

  def permalink_hash
    { :slug => self.slug, 
      :year => self.published_at.year, 
      :month => self.published_at.month.to_s.rjust(2,'0') }
  end

  def illustration
    doc = Nokogiri::HTML(content)
    img = doc.css('img').first

    if !img.nil?
      if img['src'].start_with?("/") && Rails.env == 'production'
        "http://versosperfectos.com#{img['src']}"
      else
        img['src']
      end
    else
      match_data = content.match(/(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/)

      if !match_data.nil?
        "http://img.youtube.com/vi/#{match_data.captures[4]}/hqdefault.jpg"
      else
        "http://www.basekit.es/widget/image/placeholder.png"
      end
    end
  end

  def comment_pages
    number_of_comments = comments.count
    number_of_pages = number_of_comments/ITEMS_PER_PAGE
    number_of_pages += 1 if number_of_comments % ITEMS_PER_PAGE > 0
  end

  def creator_effective_name
    self.creator ? self.creator.displayname : "VP Staff"
  end

  def visit!
    increment!(:total_read_count)
    increment!(:week_read_count)
  end

  def self.reset_weekly_read_count
    Post.update_all(week_read_count: 0)
  end

  def search_data
    {
      title: title,
      content: ActionController::Base.helpers.strip_tags(content),
      draft: draft,
      published_at: published_at
    }
  end

  private
    def get_datetimes
      self.published_at ||= Time.now  # if the published_at time is not set, set it to now
      self.published_at_date ||= self.published_at.to_date.strftime("%d/%m/%Y")
      self.published_at_time ||= "#{'%02d' % self.published_at.hour}:#{'%02d' % self.published_at.min}" # extract the time
    end

    def set_datetimes
      if published_at_date.present? and published_at_time.present?
        parsed_date = Date.strptime(published_at_date, "%d/%m/%Y")
        self.published_at = "#{parsed_date.to_s} #{self.published_at_time}:00" # convert the two fields back to db
      end
    end  

    def post_in_twitter?
      !draft && flag_twitter
    end

    def post_in_facebook?
      !draft && flag_facebook
    end

    def share_in_twitter
      client = Twitter::Client.new
      self.twitter_message ||= title
      self.twitter_message << " #{url_helpers.post_extended_url(permalink_hash)}"
      client.update(self.twitter_message)
    end

    def share_in_facebook
      graph = Koala::Facebook::API.new(ENV['FACEBOOK_OAUTH_ACCESS_TOKEN'])
      graph.put_connections("me", "feed", {link: url_helpers.post_extended_url(permalink_hash), message: self.title})
    end
end
