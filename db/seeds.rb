# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'geocoder'

case Rails.env
when "development"
  puts "Redoing DB..."
  User.destroy_all
  Pet.destroy_all
  Adoption.destroy_all
  10.times do
    user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "123123",
      cpf: "123456789",
      telephone: Faker::PhoneNumber.cell_phone,
      address: Faker::Address.street_address
    )
    #address = Geocoder.search(Faker::Address.city)

    Pet.create!(
      name: Faker::Creature::Dog.name,
      pet_type: ["dog", "cat"].sample,
      breed: Faker::Creature::Dog.breed,
      colour: Faker::Color.color_name,
      size: Faker::Creature::Dog.age,
      weight: Faker::Creature::Dog.size,
      address: Faker::Address.street_address,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      description: Faker::Lorem.sentence,
      user: user
    )
  end
  puts "Finished"
end
