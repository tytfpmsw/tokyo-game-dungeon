class Front::ExhibitInformationsController < ApplicationController
  def index
    @place_block = PlaceBlockMaster.find_by(params[:place_block])
    if @place_block
      @exhibitors = Exhibitor.where(place_block_master_id: @place_block.id)
      @exhibit_informations = ExhibitInformation.where(exhibitor: @exhibitors)
    else
      @exhibit_informations = ExhibitInformation.all
    end
  end

  def show
  end
end
