# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

survey = Survey.create!
[
  {
    name: 'São Paulo',
    image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/S%C3%A3o_Paulo_City_Center.jpg/1024px-S%C3%A3o_Paulo_City_Center.jpg'    },
  {
    name: 'Rio de Janeiro',
    image_url: 'https://upload.wikimedia.org/wikipedia/commons/c/c2/Forte_de_Copacabana_panorama.jpg'
  },
  {
    name: 'Dublin',
    image_url: 'https://lonelyplanetimages.imgix.net/mastheads/stock-photo-temple-bar-district-in-dublin-at-night-100904953%20.jpg'
  },
  {
    name: 'Barcelona',
    image_url: 'http://cosinfo.gatech.edu/images/park.jpg'
  },
  {
    name: 'Lisboa',
    image_url: 'http://www.vortexmag.net/wp-content/uploads/2015/03/Nelson.jpg'
  }
].each { |option| Option.where(survey: survey).where(option).first_or_create! }