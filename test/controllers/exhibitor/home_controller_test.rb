require "test_helper"

class Exhibitor::HomeControllerTest < Exhibitor::IntegrationTest
  test "should get index" do
    get exhibitor_root_url
    assert_response :success
  end
end
