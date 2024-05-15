class Front::EventsController < ApplicationController
  
  def show
    @event = Event.find_by!(url_subdirectory: params[:url_subdirectory])
    @sponsors = @event.sponsors
  end

  def inquiry
    name = params[:name]
    email = params[:email]
    content = params[:content]
    InquiryMailer.inquiry_email(name, email, content).deliver_now
    flash[:notice] = "お問い合わせを受け付けました。"
    redirect_to front_root_path
  end
end
