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
    assert_select ".exhibitor-event", count: 1

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
    assert_select ".exhibitor-event", count: 1

    travel_to Time.current + 1.week + 2.day do
      get exhibitor_root_url
      assert_response :success
      assert_select "a[href=?]", exhibitor_event_path(@event.url_subdirectory), count: 0
      assert_select "a[href=?]", exhibitor_event_path(@future_event.url_subdirectory)
      assert_select ".exhibitor-event", count: 1
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
end
