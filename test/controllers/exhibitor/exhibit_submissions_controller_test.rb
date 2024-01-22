require "test_helper"

class Exhibitor::ExhibitSubmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exhibitor_exhibit_submissions_url
    assert_response :success
  end

  test "should get new" do
    get new_exhibitor_exhibit_submission_url
    assert_response :success
  end

  test "should post create" do
    post exhibitor_exhibit_submissions_url,
    params: {
      title: 'test',
      description: 'test',
      movie_url: 'test'
      }
    assert_response :found
  end
end
