require "net/http"

class HttpRequestService
  def self.call(url, **options)
    uri = URI(url)

    uri.query = URI.encode_www_form(options) if options.any?

    Net::HTTP.get_response(uri)
  end
end
