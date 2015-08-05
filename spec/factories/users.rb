# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :regular_user, class: User do
  	displayname "Fulanito"
  	email "fulanito@versosperfectos.com"
  	password "f00lanito"
  	password_confirmation "f00lanito"
  end

  factory :staff_member, class: User do
  	displayname "Staff member"
  	email "staff_member@versosperfectos.com"
  	password "staffador"
  	password_confirmation "staffador"
  	staff true
  end

  factory :admin, class: User do
  	displayname "Admin"
  	email "admin@versosperfectos.com"
  	password "admins0r"
  	password_confirmation "admins0r"
  	admin true
  end 
end
