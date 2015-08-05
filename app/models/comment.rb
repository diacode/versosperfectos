class Comment < ActiveRecord::Base
	belongs_to :post, counter_cache: true
  belongs_to :user, counter_cache: true

	default_scope :order => "created_at ASC"
end
