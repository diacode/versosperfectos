# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    name "MyString"
    real_name "MyString"
    international false
    bio "MyText"
    management_id 1
    mc false
    producer false
    dj false
    clip_director false
    group false
    web "MyString"
    myspace "MyString"
    slug "MyString"
    dissolved false
    inserter_id 1
    birth_date "2012-06-10"
    death_date "2012-06-10"
    twitter "MyString"
    born_place_id 1
  end
end
