require "test_helper"

class Admin::PlaceBlocksControllerTest < Admin::IntegrationTest
  setup do
    @place_block = place_blocks(:now_preparing_A)
    @unreferenced_place_block = place_blocks(:now_preparing_unreferenced)
    @event = events(:now_preparing)
  end

  test "should get index" do
    get admin_event_place_blocks_url(@event)
    assert_response :success
  end

  test "should get new" do
    get new_admin_event_place_block_url(@event)
    assert_response :success
  end

  test "should create place_block" do
    assert_difference("PlaceBlock.count") do
      post admin_event_place_blocks_url(@event), params: { name: "test", capacity: 1, event: @event }
    end
  end

  test "should show place_block" do
    get admin_event_place_block_url(@event, @place_block)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_event_place_block_url(@event, @place_block)
    assert_response :success
  end

  test "should update place_block" do
    patch admin_event_place_block_url(@event, @place_block), params: { capacity: 2 }
    assert_redirected_to admin_event_place_block_url(@event, @place_block)
    assert_equal(2, PlaceBlock.find(@place_block.id).capacity)
  end

  test "should destroy admin_place_block" do
    assert_difference("PlaceBlock.count", -1) do
      delete admin_event_place_block_url(@event, @unreferenced_place_block)
    end
  end
end
