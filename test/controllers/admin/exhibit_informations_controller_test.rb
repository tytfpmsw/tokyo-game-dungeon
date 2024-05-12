require "test_helper"

class Admin::ExhibitInformationsControllerTest < Admin::IntegrationTest
  setup do
    @event = events(:now_preparing)
    @exhibit_information = exhibit_informations(:newbie_exhibit)
  end

  test "should get index" do
    get admin_event_exhibit_informations_url(@event.id)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_event_exhibit_information_url(@event.id, @exhibit_information.id)
    assert_response :success
  end

  test "should update" do
    patch admin_event_exhibit_information_url(@event.id, @exhibit_information.id), params: {
      exhibit_information: {
        circle_name: "updatedCircle",
        title: "updatedTitle",
        genre: "adv_novel",
        is_vr: true,
        movie_url: "https://updated.com" } }
    assert_equal "updatedCircle", @exhibit_information.reload.exhibit_submission.circle_name
    assert_equal "updatedTitle", @exhibit_information.reload.exhibit_submission.title
    assert_equal "adv_novel", @exhibit_information.reload.exhibit_submission.genre
    assert_equal true, @exhibit_information.reload.exhibit_submission.is_vr
    assert_equal "https://updated.com", @exhibit_information.reload.exhibit_submission.movie_url
  end
end
