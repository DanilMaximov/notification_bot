# frozen_string_literal: true

require "test_helper"

describe CommandHandlerFunction do
  let(:described_class) { CommandHandlerFunction }
  let(:request) do
    JSON.parse(
      File.read("test/fixtures/telegram_bot_updates/command.json"),
      symbolize_names: true
    )
  end

  it "must handle /start command" do
    VCR.use_cassette("telegram_bot_api") do
      response      = described_class.process(:start, request)
      response_body = JSON.parse(response[:body])

      assert_equal 200, response[:statusCode]
      assert_equal "Hello, #{request[:message][:from][:first_name]}!", response_body["result"]["text"]
    end
  end
end
