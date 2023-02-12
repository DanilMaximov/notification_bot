# frozen_string_literal: true

require "json"

module BotClient
  class Application
    def self.handler(event:, context:)
      message = JSON.parse(event[:body], symbolize_names: true)

      CommandHandlerFunction.process(:start, message)
    end
  end
end
