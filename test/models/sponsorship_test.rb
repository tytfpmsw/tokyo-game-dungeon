require "test_helper"

class SponsorshipTest < ActiveSupport::TestCase

  setup do
    @sponsor = sponsors(:sponsor2)
    @event = events(:now_preparing)
  end

  test "should not save sponsorship without sponsor" do
    sponsorship = Sponsorship.new(event: @event)
    assert_not sponsorship.save, "Saved the sponsorship without a sponsor"
  end

  test "should not save sponsorship without event" do
    sponsorship = Sponsorship.new(sponsor: @sponsor)
    assert_not sponsorship.save, "Saved the sponsorship without an event"
  end

  test "should save sponsorship with sponsor and event" do
    sponsorship = Sponsorship.new(event: @event, sponsor: @sponsor)
    assert sponsorship.save, "Could not save the sponsorship with a sponsor and event"
  end
end
