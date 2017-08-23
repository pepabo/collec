module Slack
  class User
    def list
      users_list = client.users_list['members'].select { |u| u['deleted'] == false && u['is_bot'] == false }
      users = []
      users_list.map do |u|
        user = {
          slack_id: u['id'],
          name: u['name'],
          real_name: u['real_name'],
          avatar_url: u['profile']['image_24']
        }
        users.push user
      end
      users
    end

    def client
      @client ||= Slack::Web::Client.new
    end
  end
end
