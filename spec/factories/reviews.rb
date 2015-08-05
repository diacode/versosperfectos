# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    content "MyText"
    rating 1
    author_id 1
    album_id 1
  end
end
