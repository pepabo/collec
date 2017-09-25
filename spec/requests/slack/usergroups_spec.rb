require 'rails_helper'

RSpec.describe "Usergroups", type: :request do
  describe "GET /api/v1/slack/usergroups" do
    before do
      data = [
        {
          team_id: "T060RNRCH",
          handle: "team_admins"
        }
      ]
      expect_any_instance_of(Slack::Usergroups).to receive(:list).and_return(data)
      get '/api/v1/slack/usergroups'
    end

    it 'response 200' do
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it 'check json contents', autodoc: true do
      expect(json_parse.first['team_id']).to eq 'T060RNRCH'
      expect(json_parse.first['handle']).to eq 'team_admins'
    end
  end
end
