require "test_helper"

class Admin::ExhibitSubmissionsControllerTest < Admin::IntegrationTest

  setup do
    @event_master = event_masters(:one)
    @exhibit_submission = exhibit_submissions(:one)
  end

  test "should get index" do
    get admin_event_master_exhibit_submissions_url(@event_master.id)
    assert_response :success
  end

  test "should get show" do
    get admin_event_master_exhibit_submission_url(@event_master.id, @exhibit_submission.id)
    assert_response :success
  end

  test "should approve" do
    post approve_admin_event_master_exhibit_submission_url(@event_master.id, @exhibit_submission.id)
    assert @exhibit_submission.reload.approved?
  end

  test "should reject" do
    post reject_admin_event_master_exhibit_submission_url(@event_master.id, @exhibit_submission.id)
    assert @exhibit_submission.reload.rejected?
  end
end
