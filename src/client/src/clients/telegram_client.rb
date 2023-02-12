# frozen_string_literal: true

module TelegramClient
  class Error < StandardError; end

  class MissingTokenError < Error; end

  API_LINK = "https://api.telegram.org/bot"

  def self.send_message(chat_id:, text:)
    make_request("/sendMessage", chat_id: chat_id, text: text)
  end

  def self.make_request(command, **options)
    token = ENV["TELEGRAM_BOT_TOKEN"] || raise(MissingTokenError)

    url = API_LINK + token + command

    response = HttpRequestService.call(url, **options)

    JSON.parse(response.body, symbolize_names: true) if response.code == "200"
  end

  private_class_method :make_request
end
