require "test_helper"

class Admin::PasswordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = administrators(:one)
    sign_in @admin
  end

  test "should get edit" do
    get edit_administrator_password_url
    assert_response :success
  end

  test "should update password" do
    patch administrator_password_url, params: { password: 'password', password_confirmation: 'password' }
    assert_redirected_to admin_root_url
  end

  test "should not update password" do
    patch administrator_password_url, params: { password: 'password', password_confirmation: 'password2' }
    assert_response :unprocessable_entity
  end
end
