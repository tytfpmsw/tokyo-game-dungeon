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

  test "should get events ordered by first day in ascending" do
    events = Event.first_day_asc
    assert_equal 3, events.count, "Did not get events ordered by first day in ascending"
    assert_equal events[0], events(:past), "Did not get events ordered by first day in ascending"
    assert_equal events[1], events(:now_preparing), "Did not get events ordered by first day in ascending"
    assert_equal events[2], events(:future), "Did not get events ordered by first day in ascending"
    
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

  test "should return true when all day has floor" do
    assert @event.all_day_has_floors?, "Did not return true when all day has floor"
  end

  test "should return false when all day has no floor" do
    event = events(:future)
    assert_not event.all_day_has_floors?, "Did not return false when all day has no floor"
  end

  test "should raise error when exhibit submit period is invalid" do
    event = Event.new(
      name: "test",
      url_subdirectory: "test",
      location: 0,
      exhibit_submit_start_at: Time.zone.now,
      exhibit_submit_end_at: Time.zone.now - 1.day
    )
    assert_not event.valid?, "Validated exhibit submit period is valid"
    assert_includes event.errors.messages[:exhibit_submit_start_at], "終了日時は開始日時より後に設定してください"
  end

  test "should not publish when event is already published" do
    event = events(:past)
    assert_not event.publish, "Published the event when event is already published"
    assert event.errors.messages[:status].include?("は既に公開されています"), "Did not raise error when event is already published"
  end

  test "should not publish when event has no schedule" do
    event = events(:unpublished)
    assert_not event.publish, "Published the event when event has no schedule"
    assert event.errors.messages[:event_schedules].include?("が存在しません"), "Did not raise error when event has no schedule"
  end

  test "should publish when event is unpublished and has schedule" do
    event = events(:unpublished)
    event_schedule = event.event_schedules.create!(start_at: Time.zone.now + 1.year, end_at: Time.zone.now + 1.year)
    event.event_schedules << event_schedule
    assert event.publish, "Did not publish the event when event is unpublished and has schedule"
  end
end
