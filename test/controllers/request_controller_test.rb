require 'test_helper'

class RequestControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get request_create_url
    assert_response :success
  end

end
