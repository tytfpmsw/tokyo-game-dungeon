require "test_helper"

class Admin::EventsControllerTest < Admin::IntegrationTest
  setup do
    @event = events(:now_preparing)
  end

  test "should get index" do
    get admin_events_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference("Event.count") do
      post admin_events_url, params: { 
        name: 'test',
        url_subdirectory: 'test',
        location: :undecided,
        start_at: Time.zone.today + 12.hours,
        end_at: Time.zone.today + 17.hour,
        publish_start_at: Time.zone.now,
        exhibit_submit_start_at: Time.zone.now,
        exhibit_submit_end_at: Time.zone.now + 1.day
      }
    end

    assert_redirected_to admin_event_url(Event.last)
    @event = Event.last
    assert_equal 'test', @event.name
    assert_equal 'test', @event.url_subdirectory
    assert_equal 'undecided', @event.location
    assert_equal Time.zone.today + 12.hours, @event.event_schedule.start_at
    assert_equal Time.zone.today + 17.hours, @event.event_schedule.end_at
    assert_equal Time.zone.now, @event.publish_start_at
    assert_equal Time.zone.now, @event.exhibit_submit_start_at
    assert_equal Time.zone.now + 1.day, @event.exhibit_submit_end_at
  end

  test "should show event" do
    get admin_event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch admin_event_url(@event), params: { name: "テスト" }
    assert_redirected_to admin_event_url(@event)
  end
end
