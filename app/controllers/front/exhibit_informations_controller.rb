class Front::ExhibitInformationsController < ApplicationController

  before_action :set_event

  def index
    if (params[:place_block])
      @place_block = PlaceBlock.find_by(name: params[:place_block])
      @exhibit_informations = ExhibitInformation.where(event_id: @event.id, place_block_id: @place_block.id)
    else
      @exhibit_informations = ExhibitInformation.where(event_id: @event.id)
    end
  end

  def show
  end

  private

  def set_event
    @event = Event.find_by(url_subdirectory: params[:event_url_subdirectory])
  end
end
