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
        movie_url: "https://updated.com",
        original_work: "OriginalWork" } }
    assert_equal "updatedCircle", @exhibit_information.reload.exhibit_submission.circle_name
    assert_equal "updatedTitle", @exhibit_information.reload.exhibit_submission.title
    assert_equal "adv_novel", @exhibit_information.reload.exhibit_submission.genre
    assert_equal true, @exhibit_information.reload.exhibit_submission.is_vr
    assert_equal "https://updated.com", @exhibit_information.reload.exhibit_submission.movie_url
    assert_equal "OriginalWork", @exhibit_information.reload.exhibit_submission.original_work
  end

  test "should update when original_work is blank" do
    patch admin_event_exhibit_information_url(@event.id, @exhibit_information.id), params: {
      exhibit_information: {
        circle_name: "updatedCircle",
        title: "updatedTitle",
        genre: "adv_novel",
        is_vr: true,
        movie_url: "https://updated.com",
        original_work: "" } }
    assert_equal "updatedCircle", @exhibit_information.reload.exhibit_submission.circle_name
    assert_equal "updatedTitle", @exhibit_information.reload.exhibit_submission.title
    assert_equal "adv_novel", @exhibit_information.reload.exhibit_submission.genre
    assert_equal true, @exhibit_information.reload.exhibit_submission.is_vr
    assert_equal "https://updated.com", @exhibit_information.reload.exhibit_submission.movie_url
    assert_equal "", @exhibit_information.reload.exhibit_submission.original_work
  end

  test "should update when original_work is nil" do
    patch admin_event_exhibit_information_url(@event.id, @exhibit_information.id), params: {
      exhibit_information: {
        circle_name: "updatedCircle",
        title: "updatedTitle",
        genre: "adv_novel",
        is_vr: true,
        movie_url: "https://updated.com",
        original_work: nil } }
    assert_equal "updatedCircle", @exhibit_information.reload.exhibit_submission.circle_name
    assert_equal "updatedTitle", @exhibit_information.reload.exhibit_submission.title
    assert_equal "adv_novel", @exhibit_information.reload.exhibit_submission.genre
    assert_equal true, @exhibit_information.reload.exhibit_submission.is_vr
    assert_equal "https://updated.com", @exhibit_information.reload.exhibit_submission.movie_url
    assert_nil @exhibit_information.reload.exhibit_submission.original_work
  end

  test "should update when original_work is not present" do
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
    assert_nil @exhibit_information.reload.exhibit_submission.original_work
  end
end
