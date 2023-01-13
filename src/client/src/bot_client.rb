# frozen_string_literal: true

require "json"

module BotClient
  class Application
    TELEGRAM_BOT_TOKEN = ENV["TELEGRAM_BOT_TOKEN"].freeze

    def self.handler(event:, context:)
      puts ENV["TELEGRAM_BOT_TOKEN"]
      body = JSON.parse(event[:body], symbolize_names: true)

      return {}.to_json unless body[:message][:chat][:type] == "private"

      handler = ::CommandHandlerFunction

      handler.process(:start, body.slice(:message))
    end
  end
end
