require "test_helper"

class Admin::ExhibitorsControllerTest < Admin::IntegrationTest

  setup do
    @event = events(:now_preparing)
    @exhibitor = exhibitors(:newbie)
    @exhibitor_exhibited_and_not_registered = exhibitors(:has_exhibited_and_not_registered)
  end

  test "should get index" do
    get admin_event_exhibitors_url(@event.id)

    assert_response :success
  end

  test "should get new" do
    get new_admin_event_exhibitor_url(event_id: @event.id)
    
    assert_response :success
  end

  test "should create new exhibitor" do
    @exhibitor_count = Exhibitor.count
    @exhibit_information_count = ExhibitInformation.count
    post(admin_event_exhibitors_url(@event.id), params: { email: 'unittest@example.com' })

    assert_response :success

    created_exhibitor = Exhibitor.find_by(email: 'unittest@example.com')

    assert_not_nil(created_exhibitor)
    assert_equal(@exhibitor_count + 1, Exhibitor.count)
    assert_equal(@exhibit_information_count + 1, ExhibitInformation.count)
  end

  test "should not create new exhibitor and exhibit_information if already exists" do
    @exhibit_information_count = ExhibitInformation.count
    post(admin_event_exhibitors_url(@event.id), params: { email: @exhibitor.email })

    assert_response :unprocessable_entity
    assert_equal(@exhibit_information_count, ExhibitInformation.count)
  end

  test "should not create new exhibitor but create exhibit_information" do
    @exhibit_information_count = ExhibitInformation.count
    @exhibitor_count = Exhibitor.count
    post(admin_event_exhibitors_url(@event.id), params: { email: @exhibitor_exhibited_and_not_registered.email })

    assert_equal(@exhibitor_count, Exhibitor.count)
    assert_equal(@exhibit_information_count + 1, ExhibitInformation.count)
  end
end
