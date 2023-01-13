# frozen_string_literal: true

require "active_function"

class CommandHandlerFunction < ActiveFunction::Base
  before_action :set_message

  def start
    send_message "Hello, #{@message[:chat][:first_name]}!"

    if @send_message[:status] == :success
      render json: @send_message[:message]
    else
      render json: @send_message[:message], status: 500
    end
  end

  private

  def set_message
    @message = params
      .require(:message)
      .permit(:message_id, chat: [:id, :first_name, :username])
      .to_h
  end

  def send_message(text)
    @send_message = ::SendMessageCommand.call(chat_id: @message[:chat][:id], text: text)
  end
end
