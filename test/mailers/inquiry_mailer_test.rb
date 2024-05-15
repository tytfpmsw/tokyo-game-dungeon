require "test_helper"

class InquiryMailerTest < ActionMailer::TestCase
  test "inquiry_email" do
    mail = InquiryMailer.inquiry_email("テスト", "test@example.com", "チケットの販売はいつですか？")

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal ["inquiry@gamedungeon.jp"], mail.from
    assert_equal ["test@example.com"], mail.to
    assert_equal "新規のお問い合わせがあります", mail.subject
    assert_match "名前：テスト", mail.body.to_s
    assert_match "連絡先：test@example.com", mail.body.to_s
    assert_match "問い合わせ内容：チケットの販売はいつですか？", mail.body.to_s
  end
end
