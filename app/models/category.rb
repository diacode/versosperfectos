class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope order("name ASC")
end
