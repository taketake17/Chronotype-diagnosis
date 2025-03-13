require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  skip "should get show" do
    get users_show_url
    assert_response :success
  end
end