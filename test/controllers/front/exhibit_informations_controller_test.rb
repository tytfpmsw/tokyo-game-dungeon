require "test_helper"

class Front::ExhibitInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get front_event_master_exhibit_informations_url(event_master_id: 1)

    assert_response :success
    assert_select "h1", "東京ゲームダンジョン4_出展ブロック"
  end

  test "should get index with place_block A" do
    get front_event_master_exhibit_informations_url(event_master_id: 1, place_block: 'A')

    assert_response :success
    assert_select "h1", "東京ゲームダンジョン4_出展ブロックA"
  end

  test "should get index with place_block B" do
    get front_event_master_exhibit_informations_url(event_master_id: 1, place_block: 'B')

    assert_response :success
    assert_select "h1", "東京ゲームダンジョン4_出展ブロックB"
  end

  test "should get show" do
    get front_event_master_exhibit_information_url(event_master_id: 1, id: 1)
    assert_response :success
  end
end
