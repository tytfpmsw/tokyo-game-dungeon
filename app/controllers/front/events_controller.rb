class Front::EventsController < ApplicationController
  
  def show
    @event = Event.find_by!(url_subdirectory: params[:url_subdirectory])
    @sponsors = @event.sponsors
  end

  def inquiry
    @event = Event.find_by!(url_subdirectory: params[:event_url_subdirectory])
    success = verify_recaptcha(action: 'inquiry', minimum_score: 0.5)
    checkbox_success = verify_recaptcha unless success
    if success || checkbox_success
      name = params[:name]
      email = params[:email]
      content = params[:content]
      InquiryMailer.inquiry_email(name, email, content).deliver_now
      flash[:notice] = "お問い合わせを受け付けました。"
      redirect_to front_root_path
    else
      if !success
        @show_checkbox_recaptcha = true
      end
      render :show
    end
  end
end
