require "test_helper"

class ExhibitInformationPlaceTest < ActiveSupport::TestCase
  test "should not save when exhibit information and place block event are not same" do
    exhibit_information = exhibit_informations(:unsubmitted_exhibit)
    place_block = place_blocks(:past_A)
    exhibit_information_place = ExhibitInformationPlace.new(
      exhibit_information: exhibit_information,
      place_block: place_block,
      place_number: 3
    )

    assert_not exhibit_information_place.save
    assert_includes exhibit_information_place.errors.full_messages, "Place blockイベントが一致しません"
  end

  test "should not save when place_number already used" do
    exhibit_information = exhibit_informations(:unsubmitted_exhibit)
    place_block = place_blocks(:now_preparing_A)
    exhibit_information_place = ExhibitInformationPlace.new(
      exhibit_information: exhibit_information,
      place_block: place_block,
      place_number: 1
    )

    assert_not exhibit_information_place.save
    assert_includes exhibit_information_place.errors.full_messages, "Place numberはすでに存在します"
  end

  test "should not save when place_block is not match with event" do
    exhibit_information = exhibit_informations(:unsubmitted_exhibit)
    place_block = place_blocks(:past_A)
    exhibit_information_place = ExhibitInformationPlace.new(
      exhibit_information: exhibit_information,
      place_block: place_block,
      place_number: 3
    )

    assert_not exhibit_information_place.save
    assert_includes exhibit_information_place.errors.full_messages, "Place blockイベントが一致しません"
  end
end
