# # # This file should contain all the record creation needed to seed the database with its default values.
# # # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# # #
# # # Examples:
# # #
# # #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# # #   Mayor.create(name: 'Emanuel', city: cities.first)

# # category1 = Category.create( name: 'Safe')
# category2 = Category.create( name: 'Historic')
# category3 = Category.create( name: 'Museums and The Arts')
# category4 = Category.create( name: 'Waterways, Parks and Beaches')



# # route1 = Route.create( name: 'Coast Road', image: 'image.jpg', category: category1)
# # route2 = Route.create( name: 'Dublin Castle', image: 'image.jpg', category: category2)

Dir.glob("lib/routes/*.gpx") do |route_file|
  f = File.open(route_file)
  doc = Nokogiri::XML(f)
  trackpoints = doc.css('//trkpt')
  points = Array.new
  trackpoints.each do |trkpt|
    points << [trkpt.xpath('@lat').to_s.to_f, trkpt.xpath('@lon').to_s.to_f]
  end
  puts points
  name = doc.css('//name').first.content
  puts name


  category = doc.css('//category').first.content
  puts category
  category_id = Category.find_by_name(category).id
  puts category_id
  f.close

  Route.create!(points: points, name: name, category_id: category_id)
end
