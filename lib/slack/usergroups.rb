module Slack
  class Usergroups
    SLACK_USERGROUPS = 'slack_usergroups'.freeze

    def list
      usergroups = Rails.cache.fetch(SLACK_USERGROUPS) do
        client.usergroups_list({ include_disabled: false })['usergroups'].select { |u| u['is_usergroup'] == true }
      end
      usergroups.map do |u|
        {
          user_group_id: u['id'],
          name: u['handle'],
          description: u['description'],
        }
      end
    end

    def client
      @client ||= Slack::Web::Client.new
    end
  end
end
