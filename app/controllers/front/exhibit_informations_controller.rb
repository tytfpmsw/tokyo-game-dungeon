class Front::ExhibitInformationsController < ApplicationController
  def index
    if (params[:place_block])
      @place_block = PlaceBlockMaster.find_by(block_name: params[:place_block])
      @exhibit_informations = ExhibitInformation.where(event_master_id: :id, place_block_master_id: @place_block.id)
    else
      @exhibit_informations = ExhibitInformation.where(event_master_id: :id)
    end
  end

  def show
  end
end
