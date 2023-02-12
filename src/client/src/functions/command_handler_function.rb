# frozen_string_literal: true

class CommandHandlerFunction < BaseFunction
  def start
   sent_msg = send_message(
      chat_id: chat_id, 
      text: "Hello, #{user_first_name}!"
    )

    return if performed?

    render json: sent_msg
  end
end
