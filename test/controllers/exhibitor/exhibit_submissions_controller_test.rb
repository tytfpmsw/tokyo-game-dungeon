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
    sign_out exhibitors(:newbie)
    sign_in exhibitors(:unsubmitted)

    assert_difference('ExhibitSubmission.count') do
      post exhibitor_event_exhibit_submissions_url(@event.url_subdirectory),
      params: {
        title: 'test',
        description: 'test',
        movie_url: 'http://test'
        }
    end
  end

  test "should put update" do
    put exhibitor_event_exhibit_submission_url(@event.url_subdirectory, exhibit_submissions(:newbie_exhibit)),
    params: {
      title: 'test',
      description: 'test',
      movie_url: 'http://test'
      }
    assert_response :found
  end

  test "should not create when exhibit submission already exists" do
    assert_no_difference('ExhibitSubmission.count') do
      post exhibitor_event_exhibit_submissions_url(@event.url_subdirectory),
      params: {
        title: 'test',
        description: 'test',
        movie_url: 'http://test'
        }
    end 
  end

  test "should not create when exhibit information is nil" do
    sign_out exhibitors(:newbie)
    sign_in exhibitors(:has_exhibited_and_not_registered)

    assert_no_difference('ExhibitSubmission.count') do
      post exhibitor_event_exhibit_submissions_url(@event.url_subdirectory),
      params: {
        title: 'test',
        description: 'test',
        movie_url: 'http://test'
        }
    end
  end
end
