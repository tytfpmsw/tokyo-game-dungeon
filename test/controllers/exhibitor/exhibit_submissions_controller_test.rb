require "test_helper"

class Exhibitor::ExhibitSubmissionsControllerTest < Exhibitor::IntegrationTest

  setup do
    @event = events(:now_preparing)
  end

  test "should get index" do
    get exhibitor_event_exhibit_submissions_url(@event)
    assert_response :success
  end

  test "should get new" do
    get new_exhibitor_event_exhibit_submission_url(@event)
    assert_response :found
  end

  test "should post create" do
    post exhibitor_event_exhibit_submissions_url(@event),
    params: {
      title: 'test',
      description: 'test',
      movie_url: 'test'
      }
    assert_response :found
  end
end
