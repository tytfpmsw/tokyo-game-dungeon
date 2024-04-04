require "test_helper"

class Admin::SponsorsControllerTest < Admin::IntegrationTest
  test "should get index" do
    get admin_sponsors_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_sponsor_url
    assert_response :success
  end

  test "should create sponsor" do
    assert_difference('Sponsor.count') do
      post admin_sponsors_url, params: { sponsor: { name: 'test', url: 'http://example.com' } }
    end

    assert_redirected_to admin_sponsor_url(Sponsor.last)
  end

  test "should show sponsor" do
    sponsor = sponsors(:sponsor1)
    get admin_sponsor_url(sponsor)
    assert_response :success
  end

  test "should get edit" do
    sponsor = sponsors(:sponsor1)
    get edit_admin_sponsor_url(sponsor)
    assert_response :success
  end

  test "should update sponsor" do
    sponsor = sponsors(:sponsor1)
    patch admin_sponsor_url(sponsor), params: { sponsor: { name: 'updated' } }
    assert_redirected_to admin_sponsor_url(sponsor)
  end

  test "should destroy sponsor" do
    sponsor = sponsors(:sponsor1)
    assert_difference('Sponsor.count', -1) do
      delete admin_sponsor_url(sponsor)
    end

    assert_redirected_to admin_sponsors_url
  end
end
