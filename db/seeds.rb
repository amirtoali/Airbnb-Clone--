# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
  user = User.create(email:"amirtoali@gmail.com", password:"password")
5.times do |i|
v=Property.create({
  name:Faker::Lorem.unique.sentence(word_count: 3),
  headline:Faker::Lorem.unique.sentence(word_count: 3),
  description:Faker::Lorem.paragraph(sentence_count: 10),
  address_line_1:Faker::Address.street_name,
  address_line_2: Faker::Address.street_address,
  city:Faker::Address.city,
  state:Faker::Address.state,
  country:Faker::Address.country,
  price:Money.from_amount(5, "USD") 
}
)
v.images.attach(
  io:  File.open(File.join(Rails.root,"app/assets/property#{i+1}.webp")),
  filename: v.name
)
 ((5..10).to_a.sample).times do
     Review.create!({
      content: Faker::Lorem.paragraph(sentence_count: 10),
       cleanliness_rating: (1..5).to_a.sample,
      accuracy_rating: (1..5).to_a.sample,
      checkin_rating: (1..5).to_a.sample,
      communiction_rating: (1..5).to_a.sample,
       location_rating: (1..5).to_a.sample,
     value_rating: (1..5).to_a.sample,
      property: v,
      user: user
     })
   end
end
