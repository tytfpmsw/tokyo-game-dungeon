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
        title_url: "https://example.com/updated",
        steam_app_id: "23456",
        twitter_url: "https://x.com/updated",
        is_vr: true,
        movie_url: "https://updated.com",
        original_work: "OriginalWork",
        memo: "updated",
        delivery_usage_scale: "large",
        } }
    assert_equal "updatedCircle", @exhibit_information.reload.exhibit_submission.circle_name
    assert_equal "updatedTitle", @exhibit_information.reload.exhibit_submission.title
    assert_equal "adv_novel", @exhibit_information.reload.exhibit_submission.genre
    assert_equal "https://example.com/updated", @exhibit_information.reload.exhibit_submission.title_url
    assert_equal "https://x.com/updated", @exhibit_information.reload.exhibit_submission.twitter_url
    assert_equal 23456, @exhibit_information.reload.exhibit_submission.steam_app_id
    assert_equal true, @exhibit_information.reload.exhibit_submission.is_vr
    assert_equal "https://updated.com", @exhibit_information.reload.exhibit_submission.movie_url
    assert_equal "OriginalWork", @exhibit_information.reload.exhibit_submission.original_work
    assert_equal "updated", @exhibit_information.reload.exhibit_submission.memo
    assert_equal "large", @exhibit_information.reload.exhibit_submission.delivery_usage_scale
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
