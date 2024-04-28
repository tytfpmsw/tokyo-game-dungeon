class Front::ExhibitInformationsController < ApplicationController

  before_action :set_event

  def index
    # /events/:event_url_subdirectory/exhibit_informations?day=1
    if params[:day].present?
      @event_schedule = @event.event_schedules.offset(params[:day].to_i - 1).first
      @floors = @event_schedule.floors
      @place_blocks = @event_schedule.floors.map(&:place_blocks).flatten
      @exhibit_information_places = @event_schedule.exhibit_information_places and return
      # /events/:event_url_subdirectory/exhibit_informations?day=1&floor=３階
      if params[:floor].present?
        @floor = @event_schedule.floors.find_by(name: params[:floor])
        @place_blocks = @floor.place_blocks
        @exhibit_information_places = @floor.exhibit_information_places and return
      end
    end

    # パラメータがなければ1日目の展示情報を表示
    @event_schedule ||= @event.event_schedules.first
    @floors ||= @event_schedule.floors
    @place_blocks ||= @event_schedule.floors.map(&:place_blocks).flatten
    @exhibit_information_places ||= @event_schedule.exhibit_information_places

  end

  def show
  end

  private

  def set_event
    @event = Event.find_by(url_subdirectory: params[:event_url_subdirectory])
  end
end
