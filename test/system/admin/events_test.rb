require "application_system_test_case"

class Admin::EventsTest < ApplicationSystemTestCase
  setup do
    @admin_event = admin_events(:one)
  end

  test "visiting the index" do
    visit admin_events_url
    assert_selector "h1", text: "Events"
  end

  test "should create event" do
    visit admin_events_url
    click_on "New event"

    click_on "Create Event"

    assert_text "Event was successfully created"
    click_on "Back"
  end

  test "should update Event" do
    visit admin_event_url(@admin_event)
    click_on "Edit this event", match: :first

    click_on "Update Event"

    assert_text "Event was successfully updated"
    click_on "Back"
  end

  test "should destroy Event" do
    visit admin_event_url(@admin_event)
    click_on "Destroy this event", match: :first

    assert_text "Event was successfully destroyed"
  end
end
