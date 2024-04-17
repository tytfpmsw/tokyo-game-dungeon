require "test_helper"

class Admin::PlaceBlocksControllerTest < Admin::IntegrationTest

  setup do
    @place_block = place_blocks(:now_preparing_A)
    @unreferenced_place_block = place_blocks(:now_preparing_unreferenced)
    @floor = floors(:now_preparing_1F)
  end

  test "should get index" do
    get admin_floor_place_blocks_url(@floor)
    assert_response :success
  end

  test "should get new" do
    get new_admin_floor_place_block_url(@floor)
    assert_response :success
  end

  test "should create place_block" do
    assert_difference("PlaceBlock.count") do
      post admin_floor_place_blocks_url(@floor), params: { name: "test", capacity: 1 }
    end
  end

  test "should show place_block" do
    get admin_floor_place_block_url(@floor, @place_block)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_floor_place_block_url(@floor, @place_block)
    assert_response :success
  end

  test "should update place_block" do
    patch admin_floor_place_block_url(@floor, @place_block), params: { capacity: 2 }
    assert_equal(2, PlaceBlock.find(@place_block.id).capacity)
  end

  test "should destroy admin_place_block" do
    assert_difference("PlaceBlock.count", -1) do
      delete admin_floor_place_block_url(@floor, @unreferenced_place_block)
    end
  end
end
