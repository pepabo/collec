module Slack
  class User
    def list
      users_list = Rails.cache.fetch('slack_active_users') do
        client.users_list['members'].select { |u| u['deleted'] == false && u['is_bot'] == false }
      end
      users = []
      users_list.map do |u|
        user = {
          slack_id: u['id'],
          name: u['name'],
          real_name: u['real_name'],
          avatar_url: u['profile']['image_24']
        }
      end
    end

    def client
      @client ||= Slack::Web::Client.new
    end
  end
end
