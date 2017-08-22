require 'rails_helper'
require 'webmock/rspec'

describe Slack::User do
  before do
    WebMock.enable!
  end

  describe '#list' do
    before do
      WebMock.stub_request(:post, "https://slack.com/api/users.list").to_return(
        body: File.read("#{Rails.root}/test/fixtures/slack_user_api_response.json"),
        status: 200,
        headers: { 'Content-Type' =>  'application/json' })
      client = Slack::User.new
      @result = client.list
    end

    it { expect(@result.first[:slack_id]).to eq 'U03XXXXXX' }
    it { expect(@result.first[:name]).to eq 'testuser' }
    it { expect(@result.first[:real_name]).to eq 'テスト ユーザー Test User (テス)' }
    it { expect(@result.first[:avatar_url]).to eq 'https://avatars.slack-edge.com/2015-05-08/1111111111_aaaaaaaaaaaaaaaaaaaa_24.jpg' }
  end
end
