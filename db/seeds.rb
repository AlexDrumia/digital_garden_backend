# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Faker::Config.locale = :hr

# hnk = Organizer.create!(name: "HNK", email: "hnk@example.com")
# lisinski = Organizer.create!(name: "Lisinski", email: "lisinski@example.com")
# knap = Organizer.create!(name: "Knap", email: "knap@example.com")
# mgz = Organizer.create!(name: "Muzej Grada Zagreba", email: "mgz@example.com")

# 25.times do |i|
#   Event.create!(
#     name: Faker::Music::Opera.unique.verdi,
#     event_type: "Opera",
#     location: Faker::Address.street_address,
#     start_datetime: i.days.from_now,
#     end_datetime: i.days.from_now + 2.hours,
#     price: 0 + i,
#     organizer: hnk
#   )
# end

# 25.times do |i|
#   Event.create!(
#     name: Faker::Music.unique.album,
#     event_type: "Concert",
#     location: Faker::Address.street_address,
#     start_datetime: i.days.from_now,
#     end_datetime: i.days.from_now + 2.hours,
#     price: 0 + i,
#     organizer: lisinski
#   )
# end

# 25.times do |i|
#   Event.create!(
#     name: Faker::Theater.unique.play,
#     event_type: "Theater Play",
#     location: Faker::Address.street_address,
#     start_datetime: i.days.from_now,
#     end_datetime: i.days.from_now + 2.hours,
#     price: 0 + i,
#     organizer: knap
#   )
# end

# 25.times do |i|
#   Event.create!(
#     name: Faker::Artist.unique.name,
#     event_type: "Exhibition",
#     location: Faker::Address.street_address,
#     start_datetime: i.days.from_now,
#     end_datetime: i.days.from_now + 2.hours,
#     price: 0 + i,
#     organizer: mgz
#   )
# end
