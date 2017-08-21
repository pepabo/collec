require 'rails_helper'

describe Slack::User do
  describe '#list' do
    before do
      data = {
        "ok"=>true,
        "members"=> [ {
           "id"=>"U03XXXXXX",
           "team_id"=>"T03XXXXXX",
           "name"=>"testuser",
           "deleted"=>false,
           "color"=>"de5f24",
           "real_name"=>"テスト ユーザー Test User (テス)",
           "tz"=>"Asia/Tokyo",
           "tz_label"=>"Japan Standard Time",
           "tz_offset"=>32400,
           "profile"=>
            {"image_24"=>"https://avatars.slack-edge.com/2015-05-08/1111111111_aaaaaaaaaaaaaaaaaaaa_24.jpg",
             "image_32"=>"https://avatars.slack-edge.com/2015-05-08/1111111111_aaaaaaaaaaaaaaaaaaaa_32.jpg",
             "image_48"=>"https://avatars.slack-edge.com/2015-05-08/1111111111_aaaaaaaaaaaaaaaaaaaa_48.jpg",
             "image_72"=>"https://avatars.slack-edge.com/2015-05-08/1111111111_aaaaaaaaaaaaaaaaaaaa_72.jpg",
             "image_192"=>"https://avatars.slack-edge.com/2015-05-08/1111111111_aaaaaaaaaaaaaaaaaaaa_192.jpg",
             "image_original"=>"https://avatars.slack-edge.com/2015-05-08/1111111111_aaaaaaaaaaaaaaaaaaaa_original.jpg",
             "first_name"=>"テスト ユーザー",
             "last_name"=>"Test User (テス)",
             "title"=>"◯◯事業部 エンジニア",
             "skype"=>"pb_testuser",
             "phone"=>"",
             "avatar_hash"=>"5cdb45313c22",
             "status_text"=>"",
             "status_emoji"=>":spiral_calendar_pad:",
             "real_name"=>"テスト ユーザー Test User (テス)",
             "email"=>"dummy@pepabo.com",
             "team"=>"T03XXXXXX"},
           "is_admin"=>false,
           "is_owner"=>false,
           "is_primary_owner"=>false,
           "is_restricted"=>false,
           "is_ultra_restricted"=>false,
           "is_bot"=>false,
           "updated"=>1503314725,
           "is_app_user"=>false
        } ]
      }
      expect_any_instance_of(Slack::Web::Client).to receive(:users_list).and_return(data)
      client = Slack::User.new
      @result = client.list
    end

    it { expect(@result.first[:slack_id]).to eq 'U03XXXXXX' }
    it { expect(@result.first[:name]).to eq 'testuser' }
    it { expect(@result.first[:real_name]).to eq 'テスト ユーザー Test User (テス)' }
    it { expect(@result.first[:avatar_url]).to eq 'https://avatars.slack-edge.com/2015-05-08/1111111111_aaaaaaaaaaaaaaaaaaaa_24.jpg' }
  end
end
