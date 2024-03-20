require "application_system_test_case"

class Admin::PlaceBlocksTest < ApplicationSystemTestCase
  setup do
    @admin_place_block = admin_place_blocks(:one)
  end

  test "visiting the index" do
    visit admin_place_blocks_url
    assert_selector "h1", text: "Place blocks"
  end

  test "should create place block" do
    visit admin_place_blocks_url
    click_on "New place block"

    click_on "Create Place block"

    assert_text "Place block was successfully created"
    click_on "Back"
  end

  test "should update Place block" do
    visit admin_place_block_url(@admin_place_block)
    click_on "Edit this place block", match: :first

    click_on "Update Place block"

    assert_text "Place block was successfully updated"
    click_on "Back"
  end

  test "should destroy Place block" do
    visit admin_place_block_url(@admin_place_block)
    click_on "Destroy this place block", match: :first

    assert_text "Place block was successfully destroyed"
  end
end
