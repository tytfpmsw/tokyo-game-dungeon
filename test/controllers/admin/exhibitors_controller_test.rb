require "test_helper"

class Admin::ExhibitorsControllerTest < Admin::IntegrationTest

  setup do
    @event = events(:one)
    @exhibitor = exhibitors(:one)
  end

  test "should get index" do
    get admin_event_exhibitors_url(@event.id)

    assert_response :success
  end

  test "should get new" do
    get new_admin_event_exhibitor_url(event_id: @event.id)
    
    assert_response :success
  end

  test "should create exhibitor" do
    post(admin_event_exhibitors_url(@event.id), params: { email: 'unittest@example.com' })

    assert_response :success

    result = Exhibitor.find_by(email: 'unittest@example.com')

    assert_not_nil(result)
  end
end
