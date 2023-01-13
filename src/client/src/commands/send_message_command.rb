# frozen_string_literal: true

class SendMessageCommand
  COMMAND = "/sendMessage"

  def self.call(chat_id:, text:)
    TelegramCommand.make_request(COMMAND, chat_id: chat_id, text: text)
  end
end
