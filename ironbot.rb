require_relative 'bundle/bundler/setup'
require 'iron_worker'
require 'slack-notifier'
require 'uri'

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

text = "Hello #{channel}!"

notifier = Slack::Notifier.new webhook_url
notifier.channel  = channel
notifier.username = 'hellobot'
resp = notifier.ping text
