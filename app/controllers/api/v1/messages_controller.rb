class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where("user_id = ?", 1)
  end

  def show
    @message = Message.includes(:mentions, :message_buttons, :message_answers).
               where("user_id = ? and id = ?", 1, params[:id]).first

    @answers = []
    @message.message_buttons.each do |b|
      answer = {}
      answer[:text] = b.text
      answer[:count] = @message.message_answers.select do |a|
        a[:message_button_id] == b.id
      end.size
      answer[:percentage] = (answer[:count].to_f / @message.message_answers.size) * 100
      @answers.push(answer)
    end
  end
end
