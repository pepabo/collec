Slack.configure do |conf|
  conf.token = ENV['SLACK_OAUTH_ACCESS_TOKEN']
end
