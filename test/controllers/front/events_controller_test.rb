require "test_helper"

class Front::EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:now_preparing)
  end

  test "should show event" do
    get front_event_url(@event.url_subdirectory)
    assert_response :success
  end

  # test "should not display exhibit informations link" do
  #   get front_event_url(@event.url_subdirectory)
  #   assert_select "a[href=?]", front_event_exhibit_informations_path(@event), count: 0
  # end

  # test "should display exhibit informations link" do
  #   travel_to @event.exhibit_informations_publish_start_at + 1.day do
  #     get front_event_url(@event.url_subdirectory)
  #     assert_select "a[href=?]", front_event_exhibit_informations_path(@event)
  #   end
  # end
end
