require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sessions_url
    assert_response :success
  end
end
