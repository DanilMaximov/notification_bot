require "active_function"

class BaseFunction < ActiveFunction::Base
  TG_PEMITTED_PARAMS = [
    :message_id,
    chat: [
      :id,
      :first_name,
      :username,
      :type
    ]
  ].freeze

  before_action :set_message

  def set_message
    @message = params
                 .require(:message)
                 .permit(*TG_PEMITTED_PARAMS)
                 .to_h
  end

  protected

  def chat_id = @message[:chat][:id]
  def user_first_name = @message[:chat][:first_name]
  
  def send_message(**options)
    TelegramClient.send_message(**options)
  rescue => e
    render json: { error: e.message }, status: 500
  end
end
