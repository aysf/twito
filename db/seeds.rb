# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative '../lib/populator_fix.rb'

Like.destroy_all
Post.destroy_all
User.destroy_all

3.times do |index|
    User.create!(
        id: index+1,
        name: Faker::Name.first_name,
        email: Faker::Internet.email,
        password: Faker::Alphanumeric.alpha(number: 10),
        image_name: (index+1).to_s + ".jpg")
end

User.create!([{
    id: 4,
    name: "Budi",
    email: "budi@example.com",
    password: "123",
    image_name: "0.jpg"
}])

p "Created #{User.count} users"

30.times do |index|
    Post.create!(
        id: index+1,
        content: Faker::Lorem.paragraph_by_chars(number: 140, supplemental: false),
        user_id: rand(1..3))
end

p "Created #{Post.count} posts"

30.times do |index|
    Like.create!(
        post_id: index+1,
        user_id: rand(1..4)
    )
end

p "Created #{Like.count} likes"
