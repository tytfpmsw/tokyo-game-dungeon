class InquiryMailer < ApplicationMailer
  default to: -> { Rails.application.config.admin.email },
          from: email_address_with_name("inquiry@tokyogamedungeon.com", "東京ゲームダンジョンCMS")

  def inquiry_email(name, contact, inquiry)
    @name = name
    @contact = contact
    @inquiry = inquiry
    mail(subject: "新規のお問い合わせがあります")
  end
end
