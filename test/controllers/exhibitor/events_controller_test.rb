require "test_helper"

class Exhibitor::EventsControllerTest < Exhibitor::IntegrationTest

  setup do
    @event = events(:now_preparing)
    @future_event = events(:future)
  end

  test "should get index" do
    get exhibitor_root_url
    assert_response :success
    assert_select "a[href=?]", exhibitor_event_path(@event.url_subdirectory)
    assert_select ".exhibitor-event", count: 2 # 1イベントにつきこのクラスは2つ出力される

    travel_to Time.current + 2.day.since do
      get exhibitor_root_url
      assert_response :success
      assert_select ".exhibitor-event", count: 0
    end
  end

  test "should get index with future event" do
    ExhibitInformation.create!(event: @future_event, exhibitor: exhibitors(:newbie))
    get exhibitor_root_url
    assert_response :success
    assert_select "a[href=?]", exhibitor_event_path(@event.url_subdirectory)
    assert_select ".exhibitor-event", count: 2

    travel_to Time.current + 1.week + 2.day do
      get exhibitor_root_url
      assert_response :success
      assert_select "a[href=?]", exhibitor_event_path(@event.url_subdirectory), count: 0
      assert_select "a[href=?]", exhibitor_event_path(@future_event.url_subdirectory)
      assert_select ".exhibitor-event", count: 2
    end
  end

  test "should get show" do
    get exhibitor_event_url(@event.url_subdirectory)
    assert_response :success
  end

  test "should not get show when event is not in submit period" do
    get exhibitor_event_url(@future_event.url_subdirectory)
    assert_redirected_to exhibitor_root_url
  end

  test "should get show with new submit button" do
    sign_out exhibitors(:newbie)
    sign_in exhibitors(:unsubmitted)
    get exhibitor_event_url(@event.url_subdirectory)
    assert_response :success
    assert_select "form[action=?]", new_exhibitor_event_exhibit_submission_path(@event.url_subdirectory)
  end

  test "should get show with edit submit button" do
    get exhibitor_event_url(@event.url_subdirectory)
    assert_response :success
    assert_select "form[action=?]", edit_exhibitor_event_exhibit_submission_path(@event.url_subdirectory, exhibit_informations(:newbie_exhibit))
  end

  test "should not get show with edit submit button when status is submitted" do
    exhibit_submission = exhibit_submissions(:newbie_exhibit)
    exhibit_submission.update!(status: :submitted)

    get exhibitor_event_url(@event.url_subdirectory)
    assert_response :success
    assert_select "form[action=?]", edit_exhibitor_event_exhibit_submission_path(@event.url_subdirectory, exhibit_informations(:newbie_exhibit)), count: 0
  end
end
