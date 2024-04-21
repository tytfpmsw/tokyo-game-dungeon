require "test_helper"

class Exhibitor::ExhibitSubmissionsControllerTest < Exhibitor::IntegrationTest

  setup do
    @event = events(:now_preparing)
  end

  test "should get index" do
    get exhibitor_event_exhibit_submissions_url(@event.url_subdirectory)
    assert_response :success
  end

  test "should get edit" do
    get edit_exhibitor_event_exhibit_submission_url(@event.url_subdirectory, exhibit_submissions(:newbie_exhibit))
    assert_response :success
  end

  test "should post create" do
    post exhibitor_event_exhibit_submissions_url(@event.url_subdirectory),
    params: {
      title: 'test',
      description: 'test',
      movie_url: 'test'
      }
    assert_response :found
  end
end
