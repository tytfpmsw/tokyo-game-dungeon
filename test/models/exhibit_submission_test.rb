require "test_helper"

class ExhibitSubmissionTest < ActiveSupport::TestCase
  setup do
    @exhibit_submission = exhibit_submissions(:newbie_exhibit)
  end

  test "should be valid" do
    assert @exhibit_submission.valid?
  end

  test "should raise error when title_url is invalid" do
    @exhibit_submission.title_url = "invalid_url"
    assert_not @exhibit_submission.valid?
    assert_includes @exhibit_submission.errors.full_messages, "作品のURLは正しいURL形式で入力してください"
  end
end
