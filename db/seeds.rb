# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

hopsor = User.find_by_email "hopsor@gmail.com"
hopsor.admin = true
hopsor.staff = true
hopsor.password = "vicente-del-bosque"
hopsor.password_confirmation = "vicente-del-bosque"
hopsor.save

User.create!({:email => "fulanito@versosperfectos.com", :password => "f00lanito", :password_confirmation => "f00lanito", :displayname => "F00L4N1T0" })