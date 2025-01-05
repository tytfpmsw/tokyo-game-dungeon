require "test_helper"

class ExhibitInformationTest < ActiveSupport::TestCase
  test "order_by_title_in_event" do
    event = events(:now_preparing)
    exhibit_information1 = exhibit_informations(:has_exhibited_and_registered_exhibit_now_preparing)
    exhibit_information2 = exhibit_informations(:newbie_exhibit)
    exhibit_information3 = exhibit_informations(:unsubmitted_exhibit)
    exhibit_information4 = exhibit_informations(:destroyable_exhibit)

    exhibit_information1.update!(title: "あ")
    exhibit_information2.update!(title: "い")
    exhibit_information3.update!(title: "う")
    exhibit_information4.update!(title: "え")

    assert_equal [exhibit_information1, exhibit_information2, exhibit_information3, exhibit_information4], ExhibitInformation.order_by_title_in_event(event)

    exhibit_information1.update!(title: "え")
    exhibit_information2.update!(title: "う")
    exhibit_information3.update!(title: "い")
    exhibit_information4.update!(title: "あ")

    assert_equal [exhibit_information4, exhibit_information3, exhibit_information2, exhibit_information1], ExhibitInformation.order_by_title_in_event(event)
  end
end
