# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :draft, class: Post do
  	title "Draft"
  	content "Lorem Ipsum"
  	published_at DateTime.now
  	slug "draft"
  	total_read_count 0
  	week_read_count 0
  	closed_comments false
  	draft true
  end

end
