require_relative 'bundle/bundler/setup'
require 'iron_worker'
require 'slack-notifier'
require 'uri'
require 'json'

data_hash = 
  {name:"Roxy's Gourmet Grilled Cheese 1", day:"Friday", time:"Lunch",location:"Greenway, Dewey Square Park Plaza"},
  {name:"Roxy's Gourmet Grilled Cheese 1", day:"Friday", time:"Lunch",location:"Greenway, Dewey Square Park Plaza"}


webhook_url = IronWorker.config['webhook_url']
payload = IronWorker.payload
channel = "#bethtest"

parsed = URI.decode_www_form(payload)
parsed.each do |p|
  if p[0] == "channel_name"
    channel = p[1]
  end
end
channel = "\##{channel}" unless channel[0] == '#'

date = Date.today
day = date.strftime('%A')
text = "Foodtruck options for #{date.strftime('%A, %B %e')}:"

file = File.read('short.json')
data = JSON.parse(file)
data.each do |k, v|
  v.each do |truck|
    if truck['day'] == day
      puts "#{truck['name']} - #{truck['location']}"
    end
  end
end

notifier = Slack::Notifier.new webhook_url
notifier.channel  = channel
notifier.username = 'hellobot'
resp = notifier.ping text
