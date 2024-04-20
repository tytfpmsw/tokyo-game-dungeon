require "test_helper"

class EventScheduleTest < ActiveSupport::TestCase

  setup do
    @event_schedule = event_schedules(:now_preparing_1stday)
  end

  test "should return true when has floor" do
    assert @event_schedule.has_floor?
  end

  test "should return false when has no floor" do
    event_schedule = event_schedules(:future_1stday)
    assert_not event_schedule.has_floor?
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
end
