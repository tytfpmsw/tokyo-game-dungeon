require "test_helper"

class Admin::HomeControllerTest < Admin::IntegrationTest
  test "should get index" do
    get admin_root_url
    assert_response :success
  end
end
