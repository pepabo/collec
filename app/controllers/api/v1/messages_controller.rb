class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where("user_id = ?", 1)
  end

  def create
    head :created
  end
end
