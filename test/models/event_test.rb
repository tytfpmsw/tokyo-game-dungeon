require "test_helper"

class EventTest < ActiveSupport::TestCase

  def setup
    @event = events(:now_preparing)
  end

  test "should not save event without name" do
    event = Event.new(url_subdirectory: "test", location: 0)
    assert_not event.save, "Saved the event without a name"
  end

  test "should not save event without url_subdirectory" do
    event = Event.new(name: "test", location: 0)
    assert_not event.save, "Saved the event without a url_subdirectory"
  end

  test "should save event with name, url_subdirectory, and location" do
    event = Event.new(name: "test", url_subdirectory: "test", location: 0)
    assert event.save, "Did not save the event with name, url_subdirectory, and location"
  end

  test "should not save event with duplicate url_subdirectory" do
    event = Event.new(name: "test", url_subdirectory: @event.url_subdirectory, location: 0)
    assert_not event.save, "Saved the event with a duplicate url_subdirectory"
  end

  test "should not save event with invalid url_subdirectory" do
    event = Event.new(name: "test", url_subdirectory: "test!", location: 0)
    assert_not event.save, "Saved the event with an invalid url_subdirectory"
  end

  test "should save event with valid url_subdirectory" do
    event = Event.new(name: "test", url_subdirectory: "aaaa-_aa", location: 0)
    assert event.save, "Did not save the event with a valid url_subdirectory"
  end

  test "should save event with valid location" do
    event = Event.new(name: "test", url_subdirectory: "test", location: 0)
    assert event.save, "Did not save the event with a valid location"
  end

  test "should not save event when exhibit submit period is invalid" do
    event = Event.new(
      name: "test",
      url_subdirectory: "test",
      location: 0,
      exhibit_submit_start_at: Time.zone.now,
      exhibit_submit_end_at: Time.zone.now - 1.day
    )
    assert_not event.save, "Saved the event when exhibit submit period is invalid"
  end

  test "should get published events in ascending order of event date" do
    events = Event.published_event_date_asc
    assert_equal 2, events.count, "Did not get published events in ascending order of event date"
    assert_equal events[0], events(:now_preparing), "Did not get published events in ascending order of event date"
    assert_equal events[1], events(:future), "Did not get published events in ascending order of event date"
  end

  test "should get archived events in descending order of event date" do
    events = Event.archived_event_date_desc
    assert_equal 1, events.count, "Did not get archived events in descending order of event date"
    assert_equal events[0], events(:past), "Did not get archived events in descending order of event date"
  end
end
