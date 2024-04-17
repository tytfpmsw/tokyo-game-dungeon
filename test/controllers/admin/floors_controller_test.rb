require "test_helper"

class Admin::FloorsControllerTest < Admin::IntegrationTest
  
  def setup
    @event = events(:now_preparing)
    @floor = floors(:now_preparing_1F)
  end

  test "should get index" do
    get admin_event_floors_url(@event)
    assert_response :success
  end

  test "should get new" do
    get new_admin_event_floor_url(@event)
    assert_response :success
  end

  test "should create floor" do
    assert_difference("Floor.count") do
      post admin_event_floors_url(@event), params: { floor: { name: "test" } }
    end
  end

  test "should show floor" do
    get admin_floor_url(@floor)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_floor_url(@floor)
    assert_response :success
  end

  test "should update floor" do
    patch admin_floor_url(@floor), params: { floor: { name: "test" } }
    assert_equal("test", Floor.find(@floor.id).name)
  end

  test "should destroy floor" do
    assert_difference("Floor.count", -1) do
      delete admin_floor_url(floors(:deletable))
    end
  end

end
