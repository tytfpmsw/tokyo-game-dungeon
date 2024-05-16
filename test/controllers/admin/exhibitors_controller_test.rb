require "test_helper"

class Admin::ExhibitorsControllerTest < Admin::IntegrationTest

  setup do
    @event = events(:now_preparing)
    @exhibitor = exhibitors(:newbie)
    @exhibitor_exhibited_and_not_registered = exhibitors(:has_exhibited_and_not_registered)
    @destroyable_exhibitor = exhibitors(:destroyable_exhibitor)
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
    post(admin_event_exhibitors_url(@event.id), params: { email: 'unittest@example.com', name: 'unittest', discord_name: 'unittestdiscord', exhibitor_type: :working_adult })

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
    post(admin_event_exhibitors_url(@event.id), params: {
      email: @exhibitor_exhibited_and_not_registered.email,
      name: @exhibitor_exhibited_and_not_registered.name,
      exhibitor_type: :working_adult })

    assert_equal(@exhibitor_count, Exhibitor.count)
    assert_equal(@exhibit_information_count + 1, ExhibitInformation.count)
  end

  test "should not create but update when exhibitor already exists" do
    @exhibitor_count = Exhibitor.count
    @exhibit_information_count = ExhibitInformation.count
    post(admin_event_exhibitors_url(@event.id), params: { email: @exhibitor_exhibited_and_not_registered.email, name: 'updated_name', discord_name: 'updated_discord_name', exhibitor_type: :student})

    assert_equal(@exhibitor_count, Exhibitor.count)
    assert_equal(@exhibit_information_count + 1, ExhibitInformation.count)
    assert_equal('updated_name', Exhibitor.find(@exhibitor_exhibited_and_not_registered.id).name)
    assert_equal('updated_discord_name', Exhibitor.find(@exhibitor_exhibited_and_not_registered.id).discord_name)
    assert_equal('student', Exhibitor.find(@exhibitor_exhibited_and_not_registered.id).exhibitor_type)
  end

  test "should update exhitibor" do
    patch(admin_event_exhibitor_url(@event.id, @exhibitor.id), params: { email: 'updated@example.com', name: 'updated_name', exhibitor_type: :student })

    assert_equal('updated@example.com', Exhibitor.find(@exhibitor.id).email)
    assert_equal('updated_name', Exhibitor.find(@exhibitor.id).name)
    assert_equal('student', Exhibitor.find(@exhibitor.id).exhibitor_type)
  end

  test "should destroy exhibit_information" do
    @exhibit_information_count = ExhibitInformation.count
    delete(admin_event_exhibitor_url(@event.id, @destroyable_exhibitor.id))

    assert_equal(@exhibit_information_count - 1, ExhibitInformation.count)
  end
end
