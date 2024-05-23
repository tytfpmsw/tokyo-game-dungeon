class InquiryMailer < ApplicationMailer
  default to: -> { Rails.configuration.app.admin[:email] },
          from: email_address_with_name(Rails.configuration.app.system[:email], "東京ゲームダンジョンCMS")

  def inquiry_email(name, email, content)
    @name = name
    @email = email
    @content = content
    mail(subject: "【東京ゲームダンジョン】新規のお問い合わせがあります")
  end

  def exhibit_submission_email(exhibitor, exhibit_information)
    @exhibitor = exhibitor
    @exhibit_information = exhibit_information
    mail(subject: "【東京ゲームダンジョン】出展情報が提出されました")
  end
end
