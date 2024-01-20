require "test_helper"

class Admin::ExhibitSubmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_exhibit_submissions_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_exhibit_submissions_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_exhibit_submissions_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_exhibit_submissions_update_url
    assert_response :success
  end
end
