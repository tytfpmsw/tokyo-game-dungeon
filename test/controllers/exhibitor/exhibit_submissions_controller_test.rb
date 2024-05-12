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
        exhibit_submission: {
          title: 'test',
          description: 'test',
          movie_url: 'http://test',
          is_vr: false
        }
      }
    end
    exhibit_submission = ExhibitSubmission.find_by(exhibit_information: ExhibitInformation.find_by(exhibitor: exhibitors(:unsubmitted)))
    assert exhibit_submission.title == 'test'
    assert exhibit_submission.genre == 'undefined'
    assert exhibit_submission.description == 'test'
    assert exhibit_submission.movie_url == 'http://test'
    assert exhibit_submission.is_vr == false
    assert exhibit_submission.status == 'submitted'
  end

  test "should put update" do
    put exhibitor_event_exhibit_submission_url(@event.url_subdirectory, exhibit_submissions(:newbie_exhibit)),
    params: {
      exhibit_submission: {
        title: 'test',
        genre: 'shooting',
        description: 'test',
        movie_url: 'http://test',
        is_vr: true
      }
    }
    assert_response :found
    exhibit_submission = ExhibitSubmission.find(exhibit_submissions(:newbie_exhibit).id)
    assert exhibit_submission.title == 'test'
    assert exhibit_submission.genre == 'shooting'
    assert exhibit_submission.description == 'test'
    assert exhibit_submission.movie_url == 'http://test'
    assert exhibit_submission.is_vr == true
    assert exhibit_submission.status == 'submitted'
  end

  test "should not create when exhibit submission already exists" do
    assert_no_difference('ExhibitSubmission.count') do
      post exhibitor_event_exhibit_submissions_url(@event.url_subdirectory),
      params: {
        exhibit_submission: {
          title: 'test',
          description: 'test',
          movie_url: 'http://test'
        }
      }
    end 
  end

  test "should not create when exhibit information is nil" do
    sign_out exhibitors(:newbie)
    sign_in exhibitors(:has_exhibited_and_not_registered)

    assert_no_difference('ExhibitSubmission.count') do
      post exhibitor_event_exhibit_submissions_url(@event.url_subdirectory),
      params: {
        exhibit_submission: {
          title: 'test',
          description: 'test',
          movie_url: 'http://test'
        }
      }
    end
  end

  test "should not update when event is not in submit period" do
    
    travel_to 1.week.since do
      put exhibitor_event_exhibit_submission_url(@event.url_subdirectory, exhibit_submissions(:newbie_exhibit)),
      params: {
        exhibit_submission: {
          title: 'test',
          description: 'test',
          movie_url: 'http://test'
        }
      }
      assert_response :forbidden
      assert ExhibitSubmission.find(exhibit_submissions(:newbie_exhibit).id).title == '初出展タイトル'
    end
  end

  test "should update when original_work is filled" do
    put exhibitor_event_exhibit_submission_url(@event.url_subdirectory, exhibit_submissions(:newbie_exhibit)),
    params: {
      exhibit_submission: {
        title: 'test',
        genre: 'shooting',
        description: 'test',
        movie_url: 'http://test',
        is_vr: true,
        original_work: 'OriginalWork'
      }
    }
    assert_response :found
    exhibit_submission = ExhibitSubmission.find(exhibit_submissions(:newbie_exhibit).id)
    assert exhibit_submission.title == 'test'
    assert exhibit_submission.genre == 'shooting'
    assert exhibit_submission.description == 'test'
    assert exhibit_submission.movie_url == 'http://test'
    assert exhibit_submission.is_vr == true
    assert exhibit_submission.original_work == 'OriginalWork'
    assert exhibit_submission.status == 'submitted'
  end
end
