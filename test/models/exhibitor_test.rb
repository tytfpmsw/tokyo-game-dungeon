require "test_helper"

class ExhibitorTest < ActiveSupport::TestCase
  setup do
    @exhibitor = exhibitors(:has_exhibited_and_not_registered)
  end

  test "should get last exhibited event id" do
    event = events(:past)
    assert_equal @exhibitor.exhibit_informations.maximum(:event_id), event.id
  end

  test "should regenerate password" do
    password = @exhibitor.password
    @exhibitor.regenerate_password
    assert_not_equal password, @exhibitor.password

    mail = ExhibitorMailer.deliveries.last
    assert_equal @exhibitor.email, mail.to[0]
    assert_equal "【東京ゲームダンジョン】パスワード再発行のお知らせ", mail.subject
    assert_match "東京ゲームダンジョン出展者ページログイン用のパスワードを再設定しました。", mail.body.to_s
  end

  test "should not send email when regenerate password with argument false" do
    ExhibitorMailer.deliveries.clear
    password = @exhibitor.password
    @exhibitor.regenerate_password(send_mail: false)
    assert_not_equal password, @exhibitor.password

    assert_nil ExhibitorMailer.deliveries.last
  end
end
