require "test_helper"

class Front::ExhibitInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get front_exhibit_informations_index_url
    assert_response :success
  end

  test "should get show" do
    get front_exhibit_informations_show_url
    assert_response :success
  end
end
