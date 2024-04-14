# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview
  def inquiry_email
    InquiryMailer.inquiry_email("テスト", "test@example.com", "チケットの販売はいつですか？")
  end
end
