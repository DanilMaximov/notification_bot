# frozen_string_literal: true

require "test_helper"

describe BotClient do
  it "application must be defined" do
    assert_kind_of Class, BotClient::Application
    assert_kind_of Method, BotClient::Application.method(:handler)
  end
end
