require "test_helper"

class Exhibitor::EventsControllerTest < Exhibitor::IntegrationTest

  setup do
    @event = events(:now_preparing)
  end

  test "should get index" do
    get exhibitor_root_url
    assert_response :success
  end

  test "should get show" do
    get exhibitor_event_url(@event)
    assert_response :success
  end
end
