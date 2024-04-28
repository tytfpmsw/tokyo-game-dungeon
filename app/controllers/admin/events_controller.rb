class Admin::EventsController < Admin::ApplicationController

  before_action :set_event, only: %i[ show edit update ]

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
      exhibit_submit_end_at: event_params[:exhibit_submit_end_at]
      )
    @event_schedule = @event.event_schedules.build(start_at: event_params[:start_at], end_at: event_params[:end_at])

    Event.transaction do
      result = @event.save! && @event_schedule.save!
      redirect_to admin_event_url(@event), notice: I18n.t('admin.events.create.success')
    end
  rescue ActiveRecord::RecordInvalid => e
    render :new, status: :unprocessable_entity
    flash.now.alert = e.message
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to admin_event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params
        .permit(
          :name,
          :url_subdirectory,
          :location,
          :start_at,
          :end_at,
          :logo_image,
          :main_image,
          :publish_start_at,
          :exhibit_submit_start_at,
          :exhibit_submit_end_at
          )
    end
end
