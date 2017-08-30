class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = Message.order('id desc').all.page(params[:page]).per(10)
  end

  def new
  end
end
