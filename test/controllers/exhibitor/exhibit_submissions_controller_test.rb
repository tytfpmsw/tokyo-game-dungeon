require "test_helper"

class Exhibitor::ExhibitSubmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exhibitor_exhibit_submissions_index_url
    assert_response :success
  end

  test "should get new" do
    get exhibitor_exhibit_submissions_new_url
    assert_response :success
  end
end
