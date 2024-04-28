class Admin::PlaceBlocksController < Admin::ApplicationController

  before_action :set_floor
  before_action :set_place_block, only: %i[ show edit update destroy ]

  def index
    @place_blocks = PlaceBlock.where(floor: @floor)

    @search = PlaceBlock.ransack(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?

    @place_blocks = @search.result.page(params[:page])
  end

  def show
  end

  def new
    @place_block = PlaceBlock.new
  end

  def edit
  end

  def create
    @place_block = PlaceBlock.new(place_block_params)
    @place_block.floor_id = @floor.id

    if @place_block.save
      flash.now.notice = "ブロックを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @place_block.update(place_block_params)
      flash.now.notice = "ブロックを更新しました。" 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place_block.destroy!
    flash.now.notice = "ブロックを削除しました。"
  end

  private
    def set_floor
      @floor = Floor.find(params[:floor_id])
    end

    def set_place_block
      @place_block = PlaceBlock.find(params[:id])
    end

    def place_block_params
      params.require(:place_block).except(
      :authenticity_token,
      :commit,
      :subdomain
      ).permit(
        :name,
        :capacity)
    end
end
