require 'ffaker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

get_image = -> { "https://unsplash.it/400?#{rand(1..1013)}" }

5.times do
  user = User.create!(
    name:     FFaker::Book.author,
    username: Faker::Internet.unique.user_name,
    email:    Faker::Internet.unique.safe_email,
    password: 'pass',
    avatar:   FFaker::Avatar.image
  )
  2.times do
    gallery = Gallery.create!(
      title:      FFaker::Book.title,
      summary:    FFaker::Book.description,
      user_id:    user.id,
      main_image: "https://unsplash.it/200/300?#{rand(1..1013)}"
    )
    5.times do
      Photo.create!(
        name:       FFaker::Name.name,
        caption:    FFaker::BaconIpsum.sentence,
        image:      "https://unsplash.it/200?#{rand(1..1013)}",
        gallery_id: gallery.id
      )
    end
  end
end

puts "Seeds complete."
