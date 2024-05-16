require "test_helper"

class ExhibitorTest < ActiveSupport::TestCase
  setup do
    @exhibitor = exhibitors(:has_exhibited_and_not_registered)
  end

  test "should get last exhibited event id" do
    event = events(:past)
    assert_equal @exhibitor.exhibit_informations.maximum(:event_id), event.id
  end
end
