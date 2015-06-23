# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|
  User.create!(username: "User #{n+1}", password: "password")
  Cat.create!(
    name: "Cat #{n+1}",
    color: Cat::CAT_COLORS.sample,
    birth_date: Date.today - n.years,
    sex: ["M","F"].sample,
    user_id: n + 1
  )
end
