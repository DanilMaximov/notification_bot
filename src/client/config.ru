# frozen_string_literal: true

require "zeitwerk"
require "listen"

loader = Zeitwerk::Loader.new
loader.push_dir("./src")
loader.push_dir("./src/functions")
loader.push_dir("./src/commands")
loader.enable_reloading
loader.setup

listener = Listen.to("./src") { loader.reload }
listener.start

application = lambda do |env|
  req = Rack::Request.new(env)

  event = {
    body: req.body.read
  }

  response = BotClient::Application.handler(event: event, context: nil)

  puts response

  [
    response[:statusCode],
    response[:headers].transform_keys(&:downcase),
    [response[:body]]
  ]
end

run application
