class Front::EventsController < ApplicationController
  
  def show
    @event = Event.find_by!(url_subdirectory: params[:url_subdirectory])
    @sponsors = @event.sponsors
  end

  def inquiry
    @event = Event.find_by!(url_subdirectory: params[:event_url_subdirectory])
    if verify_recaptcha(action: 'inquiry', minimum_score: 0.5)
      name = params[:name]
      email = params[:email]
      content = params[:content]
      InquiryMailer.inquiry_email(name, email, content).deliver_now
      flash[:notice] = "お問い合わせを受け付けました。"
      redirect_to front_root_path
    else
      flash[:alert] = "reCAPTCHAによる認証に失敗しました。時間をおいて再度お試しください。"
      redirect_to front_root_path
    end
  end
end
