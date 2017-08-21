module Slack
  class User
    def list
      users_list = client.users_list['members'].select { |u| u['deleted'] == false && u['is_bot'] == false }
      users = []
      users_list.each do |u|
        user = {}
        user[:slack_id] = u['id']
        user[:name] = u['name']
        user[:real_name] = u['real_name']
        user[:avatar_url] = u['profile']['image_24']
        users.push user
      end
      users
    end

    def client
      @client ||= Slack::Web::Client.new
    end
  end
end
