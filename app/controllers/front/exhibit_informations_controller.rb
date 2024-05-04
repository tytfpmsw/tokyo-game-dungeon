class Front::ExhibitInformationsController < ApplicationController

  before_action :set_event

  def index
    exhibit_information_places = ExhibitInformationPlace.includes(:place_block, :exhibit_information).where(place_block: @event.place_blocks)

    # dayとfloorが指定されたら、その日のそのフロアの展示情報を表示
    if params[:day].present? && params[:floor].present?
      @event_schedule = @event.event_schedules.offset(params[:day].to_i - 1).first
      @floor = @event_schedule.floors.find_by(name: params[:floor])
      @place_blocks = @floor.place_blocks
      @exhibit_information_places = exhibit_information_places.where(place_block: @place_blocks) and return
    end

    # dayのみが指定されたら、その日のidが一番最初のフロアの展示情報を表示
    if params[:day].present?
      @event_schedule = @event.event_schedules.offset(params[:day].to_i - 1).first
      @floor = @event_schedule.floors.first
      @place_blocks = @event_schedule.floors.first.place_blocks
      @exhibit_information_places = exhibit_information_places.where(place_block: @place_blocks) and return
    end

    # パラメータがなければ1日目のidが一番最初のフロアの展示情報を表示
    @event_schedule = @event.event_schedules.first
    @floor = @event_schedule.floors.first
    @place_blocks = @event_schedule.floors.first.place_blocks
    @exhibit_information_places = exhibit_information_places.where(place_block: @place_blocks)
  end

  def show
  end

  private

  def set_event
    @event = Event.find_by(url_subdirectory: params[:event_url_subdirectory])
  end
end
