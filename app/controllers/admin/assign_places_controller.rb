class Admin::AssignPlacesController < Admin::ApplicationController

  before_action :set_place_block, only: [:index, :edit, :update, :destroy]

  def index
    @exhibit_information_places = ExhibitInformationPlace.where(place_block: @place_block)
    @exhibit_informations = @exhibit_information_places.map(&:exhibit_information)
  end

  def edit
    @exhibit_informations = ExhibitInformation.where(event: @place_block.event)
    @number = params[:number].to_i
  end

  def update
    @exhibit_information = ExhibitInformation.find(params[:exhibit_information_id])
    @number = params[:number].to_i

    @exhibit_information_place = ExhibitInformationPlace.find_by(place_block: @place_block, place_number: @number, exhibit_information: @exhibit_information)
    unless @exhibit_information_place.present?
      @exhibit_information_place = ExhibitInformationPlace.new(place_block: @place_block, place_number: @number)
    end
    @exhibit_information_place.exhibit_information = @exhibit_information

    if @exhibit_information_place.save
      flash.now.notice = "配置しました。"
      @exhibit_information_places = ExhibitInformationPlace.where(place_block: @place_block)
    else
      @exhibit_informations = ExhibitInformation.where(event: @place_block.event)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @number = params[:number].to_i

    @exhibit_information_place = ExhibitInformationPlace.find_by(place_block: @place_block, place_number: @number)

    @target_place = ExhibitInformationPlace.where(place_block: @place_block, place_number: @number)
    @target_place.destroy_all

    @exhibit_information_places = ExhibitInformationPlace.where(place_block: @place_block)
    flash.now.notice = "配置を解除しました。"
  end

  private

  def set_place_block
    @place_block = PlaceBlock.find(params[:place_block_id])
  end
end
