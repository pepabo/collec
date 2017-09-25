class Api::V1::Slack::UsergroupsController < ApplicationController
  def index
    client = Slack::Usergroups.new
    @usergroups = client.list
  end
end
