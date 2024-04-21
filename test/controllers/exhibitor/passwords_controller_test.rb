require "test_helper"

class Exhibitor::PasswordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @exhibitor = exhibitors(:newbie)
    sign_in @exhibitor
  end

  test "should get edit" do
    get edit_exhibitor_password_url
    assert_response :success
  end

  test "should update password" do
    patch exhibitor_password_url, params: { password: 'password', password_confirmation: 'password' }
    assert_redirected_to exhibitor_root_url
  end

  test "should not update password" do
    patch exhibitor_password_url, params: { password: 'password', password_confirmation: 'password2' }
    assert_response :unprocessable_entity
  end
end
