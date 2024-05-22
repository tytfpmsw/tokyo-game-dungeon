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
    exhibit_submission.title_url = "https://example.com/updated"
    exhibit_submission.twitter_url = "https://x.com/updated"
    exhibit_submission.steam_app_id = 34567
    exhibit_submission.memo = "updated"
    exhibit_submission.delivery_usage_scale = "large"
    exhibit_submission.save
    post approve_admin_event_exhibit_submission_url(@event.id, @exhibit_submission.id)
    assert @exhibit_submission.reload.status_approved?
    assert @exhibit_information.reload.is_vr?
    assert_equal "https://example.com/updated", @exhibit_information.reload.title_url
    assert_equal "https://x.com/updated", @exhibit_information.reload.twitter_url
    assert_equal 34567, @exhibit_information.reload.steam_app_id
    assert_equal "updated", @exhibit_information.reload.memo
    assert_equal "large", @exhibit_information.reload.delivery_usage_scale
  end

  test "should reject" do
    post reject_admin_event_exhibit_submission_url(@event.id, @exhibit_submission.id)
    assert @exhibit_submission.reload.status_rejected?
  end
end
