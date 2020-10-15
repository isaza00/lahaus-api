# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create(email: "ejemplo1@mail.com", password: "1234", full_name: "juan", cellphone: "3001234567")
user2 = User.create(email: "ejemplo2@mail.com", password: "1234", full_name: "pedro", cellphone: "3001234567")
user3 = User.create(email: "ejemplo3@mail.com", password: "1234", full_name: "lucas", cellphone: "3001234567")
user4 = User.create(email: "ejemplo4@mail.com", password: "1234", full_name: "mateo", cellphone: "3001234567")
user5 = User.create(email: "ejemplo5@mail.com", password: "1234", full_name: "judas", cellphone: "3001234567")
admin = User.create(email: "admin@mail.com", password: "admin1234", isadmin: true, full_name: "admin", cellphone: "3001234567")

property1 = Property.create(user_id: 1, city:"Medellin", hood:"Belen", built_type:"Casa")
property1 = Property.create(user_id: 2, city:"Medellin", hood:"Poblado", built_type:"Apartamento")
property1 = Property.create(user_id: 3, city:"Medellin", hood:"Laureles", built_type:"Casa")
property1 = Property.create(user_id: 4, city:"Medellin", hood:"La America", built_type:"Apartamento")
property1 = Property.create(user_id: 5, city:"Medellin", hood:"Belen", built_type:"Casa")

photo1 = Photo.create(property_id: 1, url: "http://url.com")
photo2 = Photo.create(property_id: 1, url: "http://url.com")
photo3 = Photo.create(property_id: 2, url: "http://url.com")
photo4 = Photo.create(property_id: 3, url: "http://url.com")
photo5 = Photo.create(property_id: 4, url: "http://url.com")
