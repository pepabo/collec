require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_message_url
    assert_response :success
  end

end
