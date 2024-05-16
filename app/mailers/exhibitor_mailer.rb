class ExhibitorMailer < ApplicationMailer
  default from: email_address_with_name(Rails.configuration.app.system[:email], "東京ゲームダンジョン")

  def exhibitor_registered_email(exhibitor_email, event_name, password)
    @event_name = event_name
    @password = password
    mail(
      to: exhibitor_email,
      bcc: Rails.configuration.app.admin[:email],
      subject: "【東京ゲームダンジョン】ログイン用パスワードのお知らせ"
      )
  end

  def event_registered_email(exhibitor_email, event_name)
    @event_name = event_name
    mail(
      to: exhibitor_email,
      bcc: Rails.configuration.app.admin[:email],
      subject: "【東京ゲームダンジョン】イベント出展登録完了のお知らせ"
    )
  end

  def exhibit_submission_approved_email(exhibitor_email)
    mail(
      to: exhibitor_email,
      bcc: Rails.configuration.app.admin[:email],
      subject: "【東京ゲームダンジョン】出展申請が承認されました"
    )
  end
end
