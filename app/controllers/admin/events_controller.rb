class Admin::EventsController < Admin::ApplicationController

  before_action :set_event, only: %i[ show edit update publish ]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(
      name: event_params[:name],
      url_subdirectory: event_params[:url_subdirectory],
      status: :unpublished,
      location: event_params[:location],
      logo_image: event_params[:logo_image],
      main_image: event_params[:main_image],
      publish_start_at: event_params[:publish_start_at],
      exhibit_submit_start_at: event_params[:exhibit_submit_start_at],
      exhibit_submit_end_at: event_params[:exhibit_submit_end_at],
      exhibit_informations_publish_start_at: event_params[:exhibit_informations_publish_start_at]
      )

      if @event.save
        redirect_to admin_event_url(@event), notice: "イベントを作成しました。"
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
    if @event.update(event_params)
      redirect_to admin_event_url(@event), notice: "イベントを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def publish
    if @event.publish
      redirect_to admin_event_url(@event), notice: 'イベントを公開しました。'
    else
      redirect_to admin_event_url(event), alert: "#{@event.errors.full_messages.join(', ')}"
    end
  end

  def unpublish
    @event.unpublish
    redirect_to admin_event_url(@event), notice: 'イベントを非公開にしました。'
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params
        .require(:event)
        .permit(
          :name,
          :url_subdirectory,
          :location,
          :logo_image,
          :main_image,
          :publish_start_at,
          :exhibit_submit_start_at,
          :exhibit_submit_end_at,
          :exhibit_informations_publish_start_at
          )
    end
end
