require "test_helper"

class EventScheduleTest < ActiveSupport::TestCase

  setup do
    @event = events(:now_preparing)
    @event_schedule = event_schedules(:now_preparing_1stday)
  end

  test "should return true when has floor" do
    assert @event_schedule.has_floors?
  end

  test "should return false when has no floor" do
    event_schedule = event_schedules(:future_1stday)
    assert_not event_schedule.has_floors?
  end

  test "should validate start_at should be before end_at" do
    event_schedule = EventSchedule.new(
      event: events(:now_preparing),
      start_at: Time.zone.now,
      end_at: Time.zone.now - 1.day
    )
    assert_not event_schedule.valid?
    assert_includes event_schedule.errors.messages[:start_at], 'は終了日時よりも前に設定してください'
  end

  test "should validate start_at and end_at should be same day" do
    event_schedule = EventSchedule.new(
      event: events(:now_preparing),
      start_at: Time.zone.now,
      end_at: Time.zone.now + 1.day
    )
    assert_not event_schedule.valid?
    assert_includes event_schedule.errors.messages[:start_at], 'と終了日時は同じ日に設定してください'
  end

  test "should return day number in event" do
    assert_equal 1, @event_schedule.day_number_in_event
    EventSchedule.create(
      event: events(:now_preparing),
      start_at: @event_schedule.start_at + 1.day,
      end_at: @event_schedule.end_at + 1.day
    )
    assert_equal 2, EventSchedule.last.day_number_in_event
  end

  test "should destroy" do
    event_schedule = EventSchedule.create(
      event: events(:now_preparing),
      start_at: @event_schedule.start_at + 1.day,
      end_at: @event_schedule.end_at + 1.day
    )
    assert_difference('EventSchedule.count', -1) do
      event_schedule.destroy
    end
  end

  test "should not destroy when the schedule has floor" do
    assert_no_difference('EventSchedule.count') do
      @event_schedule.destroy
      assert_includes @event_schedule.errors.messages[:base], 'floorsが存在しているので削除できません'
    end
  end

  test "should not destroy when the event has only one schedule" do
    event = Event.create(
      name: 'Test Event',
      url_subdirectory: 'test_event',
      location: :hamamatsu_tsbc,
    )
    event_schedule = EventSchedule.create(
      event: event,
      start_at: Time.zone.now.strftime('%Y-%m-%d 12:00:00 +0900'),
      end_at: Time.zone.now.strftime('%Y-%m-%d 17:00:00 +0900')
    )
    assert_no_difference('EventSchedule.count') do
      event_schedule.destroy
      assert_includes event_schedule.errors.messages[:base], 'イベントには1つ以上の開催日が必要です'
    end
  end
end
