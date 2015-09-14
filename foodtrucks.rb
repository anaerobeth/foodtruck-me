require 'date'
require 'json'
date = Date.today
day = date.strftime('%A')
text = "Foodtruck options for #{date.strftime('%A, %B %e')}:"

file = File.read('short.json')
data = JSON.parse(file)
TRUCKS =
  [
    "Greenway, Rowes Wharf Plaza",
    "Financial District, Pearl Street at Franklin",
    "Financial District, Milk and Kilby Streets",
    "Greenway, Dewey Square Park Plaza",
    "Greenway, Dewey Square Park at Congress St",
    "Financial District, Pearl Street at Franklin"
  ]
data.each do |k, v|
  v.each do |truck|
    if TRUCKS.include?(truck['location'])
      puts v
    end
  end
end
