require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/v1/slack/users" do
    before do
      data = [
        {
          slack_id: "UHOGE",
          name: "hypermkt",
          real_name: "千葉 誠 Makoto Chiba (バーチー)",
          avatar_url: "http://hoge.io/001.jpg"
        }
      ]
      expect_any_instance_of(Slack::User).to receive(:list).and_return(data)
      get '/api/v1/slack/users'
    end

    it 'response 200' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'check json contents' do
      expect(json_parse.first['slack_id']).to eq 'UHOGE'
      expect(json_parse.first['name']).to eq 'hypermkt'
      expect(json_parse.first['real_name']).to eq '千葉 誠 Makoto Chiba (バーチー)'
      expect(json_parse.first['avatar_url']).to eq 'http://hoge.io/001.jpg'
    end
  end
end
