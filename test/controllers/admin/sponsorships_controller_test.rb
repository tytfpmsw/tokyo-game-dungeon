require "test_helper"

class Admin::SponsorshipsControllerTest < Admin::IntegrationTest
  setup do
    @event = events(:now_preparing)
  end

  test "should get index" do
    get admin_event_sponsorships_url(@event)
    assert_response :success
  end

  test "should get new" do
    get new_admin_event_sponsorship_url(@event)
    assert_response :success
  end

  test "should create sponsorship" do
    sponsor = sponsors(:sponsor2)
    assert_difference('Sponsorship.count') do
      post admin_event_sponsorships_url(@event), params: { sponsorship: { event_id: @event.id, sponsor_id: sponsor.id } }
    end
  end

  test "should not create sponsorship" do
    sponsor = sponsors(:sponsor1)
    assert_no_difference('Sponsorship.count') do
      post admin_event_sponsorships_url(@event), params: { sponsorship: { event_id: @event.id, sponsor_id: sponsor.id } }
    end
  
  end

  test "should get edit" do
    sponsorship = sponsorships(:now_preparing_sponsor1)
    get edit_admin_event_sponsorship_url(@event, sponsorship)
    assert_response :success
  end

  test "should destroy sponsorship" do
    sponsorship = sponsorships(:now_preparing_sponsor1)
    assert_difference('Sponsorship.count', -1) do
      delete admin_event_sponsorship_url(@event, sponsorship)
    end
  end
end
