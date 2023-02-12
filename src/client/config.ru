# frozen_string_literal: true

require "zeitwerk"
require "listen"
require "json"

loader = Zeitwerk::Loader.new
loader.push_dir("./src")
loader.push_dir("./src/functions")
loader.push_dir("./src/services")
loader.push_dir("./src/clients")
loader.enable_reloading
loader.setup

listener = Listen.to("./src") { loader.reload }
listener.start

application = lambda do |env|
  req      = Rack::Request.new(env)
  event    = {body: req.body.read}

  response = BotClient::Application.handler(event: event, context: nil)

  status, headers, body = response.values

  [status, headers.transform_keys(&:downcase), Array[body]]
end

run application
