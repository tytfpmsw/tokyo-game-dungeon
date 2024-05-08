require "test_helper"

class Admin::ExhibitSubmissionsControllerTest < Admin::IntegrationTest

  setup do
    @event = events(:now_preparing)
    @exhibit_submission = exhibit_submissions(:newbie_exhibit)
    @exhibit_information = exhibit_informations(:newbie_exhibit)
  end

  test "should get index" do
    get admin_event_exhibit_submissions_url(@event.id)
    assert_response :success
  end

  test "should get show" do
    get admin_event_exhibit_submission_url(@event.id, @exhibit_submission.id)
    assert_response :success
  end

  test "should approve" do
    exhibit_submission = exhibit_submissions(:newbie_exhibit)
    exhibit_submission.is_vr = true
    exhibit_submission.save
    post approve_admin_event_exhibit_submission_url(@event.id, @exhibit_submission.id)
    assert @exhibit_submission.reload.status_approved?
    assert @exhibit_information.reload.is_vr?
  end

  test "should reject" do
    post reject_admin_event_exhibit_submission_url(@event.id, @exhibit_submission.id)
    assert @exhibit_submission.reload.status_rejected?
  end
end
