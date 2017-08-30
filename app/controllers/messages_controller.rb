class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = Message.all.page(params[:page]).per(10)
  end

  def new
  end
end
