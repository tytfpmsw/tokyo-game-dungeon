class Front::EventsController < ApplicationController
  def index
    @events = Event.all
  end
  
  def show
    @event = Event.find_by!(url_subdirectory: params[:url_subdirectory])
    case Event.locations[@event.location]
    when Event.locations[:hamamatsu_tsbc] then
      render :show_hamamatsu_tsbc
    when Event.locations[:note_place] then
      render :show_note_place
    else
      render :show
    end
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
