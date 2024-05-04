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
        event: {
          name: 'test',
          url_subdirectory: 'test',
          location: :undecided,
          publish_start_at: Time.zone.now,
          exhibit_submit_start_at: Time.zone.now,
          exhibit_submit_end_at: Time.zone.now + 1.day
        }
      }
    end

    assert_redirected_to admin_event_url(Event.last)
    @event = Event.last
    assert_equal 'test', @event.name
    assert_equal 'test', @event.url_subdirectory
    assert_equal 'undecided', @event.location
    assert_equal Time.zone.now.floor, @event.publish_start_at
    assert_equal Time.zone.now.floor, @event.exhibit_submit_start_at
    expected_submit_end_at = Time.zone.now + 1.day
    assert_equal expected_submit_end_at.floor, @event.exhibit_submit_end_at
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
    patch admin_event_url(@event), params: { event: { name: "テスト" } }
    assert_redirected_to admin_event_url(@event)
  end
end
