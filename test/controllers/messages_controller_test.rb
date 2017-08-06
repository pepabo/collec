require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get messages_create_url
    assert_response :success
  end

end
