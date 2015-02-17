# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

category1 = Category.create( name: 'Safe')
category2 = Category.create( name: 'Historic')


route1 = Route.create( name: 'Coast Road', image: 'image.jpg', category: category1)
route2 = Route.create( name: 'Dublin Castle', image: 'image.jpg', category: category2)