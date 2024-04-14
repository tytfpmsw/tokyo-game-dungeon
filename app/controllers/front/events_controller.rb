class Front::EventsController < ApplicationController
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find(params[:id])
  end

  def inquiry
    name = params[:name]
    contact = params[:contact]
    inquiry = params[:inquiry]
    InquiryMailer.inquiry_email(name, contact, inquiry).deliver_now
    flash[:notice] = "お問い合わせを受け付けました。"
    redirect_to front_root_path
  end
end
