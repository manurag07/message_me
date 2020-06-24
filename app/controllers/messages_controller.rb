# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    return if params[:message][:body] == ''

    message = current_user.messages.build(chat_params)
    if message.save
      ActionCable.server.broadcast 'chatroom_channel',
                                   mod_message: render_message(message)
    end
  end

  private

  def chat_params
    params.require(:message).permit(:body)
  end

  def render_message(message)
    render(partial: 'message', locals: { message: message })
  end
end
