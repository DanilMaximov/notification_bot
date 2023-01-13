# frozen_string_literal: true

require "net/http"

class TelegramCommand
  ALL_NET_HTTP_ERRORS = [
    Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
    Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
  ].freeze

  API_LINK = "https://api.telegram.org/bot"

  def self.make_request(command, token: BotClient::Application::TELEGRAM_BOT_TOKEN, **options)
    uri = URI(API_LINK + token + command)

    uri.query = URI.encode_www_form(options)

    response = Net::HTTP.get_response(uri)
  rescue *ALL_NET_HTTP_ERRORS => e
    {status: :error, message: e.message}
  else
    {status: :success, message: response.body}
  end
end
