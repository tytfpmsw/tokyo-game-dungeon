class Admin::ExhibitInformationsController < Admin::ApplicationController

  before_action :set_event

  def index
    @exhibit_informations = @event.exhibit_informations
  end

  def edit
    @exhibit_information = @event.exhibit_informations.find(params[:id])
  end

  def update
    @exhibit_information = @event.exhibit_informations.find(params[:id])
    if @exhibit_information.update(exhibit_information_params)
      flash.now.notice = '出展情報を更新しました'
      redirect_to admin_event_exhibit_informations_path(@event), notice: '出展情報を更新しました'
    else
      render :edit
    end
  end

  private

  def exhibit_information_params
    params.require(:exhibit_information).permit(:circle_name, :title, :description, :movie_url, :image)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
