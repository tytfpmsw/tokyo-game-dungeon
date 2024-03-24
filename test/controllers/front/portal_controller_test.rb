require "test_helper"

class PortalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get front_root_url
    assert_response :success
  end
end
