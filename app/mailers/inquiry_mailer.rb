class InquiryMailer < ApplicationMailer
  default to: -> { Rails.application.config.admin_email },
          from: email_address_with_name("inquiry@gamedungeon.jp", "東京ゲームダンジョンCMS")

  def inquiry_email(name, email, content)
    @name = name
    @email = email
    @content = content
    mail(subject: "新規のお問い合わせがあります")
  end
end
