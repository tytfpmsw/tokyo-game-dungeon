class Front::ExhibitInformationsController < ApplicationController

  before_action :set_event

  def index
    exhibit_information_places = ExhibitInformationPlace.includes(:place_block, :exhibit_information).where(place_block: @event.place_blocks)

    if params[:day].present?
      @event_schedule = @event.event_schedules.offset(params[:day].to_i - 1).first
      @floor = params[:floor].present? ? @event_schedule.floors.find_by(name: params[:floor]) : @event_schedule.floors.first
      @place_blocks = @floor.place_blocks
      @exhibit_information_places = exhibit_information_places.where(place_block: @place_blocks) and return
    end

    # パラメータがない場合は初日の最初のフロアの情報を表示
    @event_schedule = @event.event_schedules.first
    @floor = @event_schedule.floors.first
    @place_blocks = @event_schedule.floors.first.place_blocks
    @exhibit_information_places = exhibit_information_places.where(place_block: @place_blocks).order(:place_block_id, :place_number)
  end

  def show
    @exhibit_information = ExhibitInformation.find(params[:id])
  end

  private

  def set_event
    @event = Event.find_by(url_subdirectory: params[:event_url_subdirectory])
  end

  def return_top_before_exhibit_information_publish
    if  Time.zone.now < @event.exhibit_information_publish_start_at
      redirect_to front_event_path(@event.url_subdirectory)
    end
  end
end
