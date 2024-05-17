require "test_helper"

class ExhibitorMailerTest < ActionMailer::TestCase
  test "exhibitor_registered_email" do
    mail = ExhibitorMailer.exhibitor_registered_email(
      "exhibitor@example.com",
      "東京ゲームダンジョン２",
      "password123")

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal ["system@gamedungeon.jp"], mail.from
    assert_equal ["exhibitor@example.com"], mail.to
    assert_equal ["test@example.com"], mail.bcc
    assert_equal "【東京ゲームダンジョン】ログイン用パスワードのお知らせ", mail.subject
    assert_match "東京ゲームダンジョン２への出展登録が完了しました。", mail.body.to_s
    assert_match "初期パスワード： password123", mail.body.to_s
    assert_match "https://", mail.body.to_s
  end

  test "event_registered_email" do
    mail = ExhibitorMailer.event_registered_email(
      "exhibitor@example.com",
      "東京ゲームダンジョン２")

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal ["system@gamedungeon.jp"], mail.from
    assert_equal ["exhibitor@example.com"], mail.to
    assert_equal ["test@example.com"], mail.bcc
    assert_equal "【東京ゲームダンジョン】イベント出展登録完了のお知らせ", mail.subject
    assert_match "東京ゲームダンジョン２への出展登録が完了しました。", mail.body.to_s
    assert_match "パスワードは前回まで使用していたものを引き続き使用できます。", mail.body.to_s
    assert_match "https://", mail.body.to_s
  end
end
