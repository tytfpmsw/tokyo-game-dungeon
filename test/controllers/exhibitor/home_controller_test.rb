require "test_helper"

class Exhibitor::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exhibitor_home_index_url
    assert_response :success
  end
end
