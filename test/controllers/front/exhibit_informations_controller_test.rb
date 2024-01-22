require "test_helper"

class Front::ExhibitInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get front_exhibit_informations_index_url

    assert_response :success
    assert_select "h1", "東京ゲームダンジョン4_出展ブロック"
  end

  test "should get index with place_block" do
    get front_exhibit_informations_index_url, params: { place_block: 'A' }

    assert_response :success
    assert_select "h1", "東京ゲームダンジョン4_出展ブロックA"
  end

  test "should get show" do
    get front_exhibit_informations_show_url
    assert_response :success
  end
end
