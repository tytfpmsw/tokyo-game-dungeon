class Admin::PlaceBlocksController < ApplicationController

  before_action :authenticate_administrator!
  before_action :set_event
  before_action :set_place_block, only: %i[ show edit update destroy ]

  # GET /admin_place_blocks or /admin_place_blocks.json
  def index
    @place_blocks = PlaceBlock.where(event_id: @event.id)
  end

  # GET /admin_place_blocks/1 or //admin_place_blocks/1.json
  def show
  end

  # GET /admin_place_blocks/new
  def new
    @place_block = PlaceBlock.new
  end

  # GET /admin_place_blocks/1/edit
  def edit
  end

  # POST /admin_place_blocks or /admin_place_blocks.json
  def create
    @place_block = PlaceBlock.new(place_block_params)

    respond_to do |format|
      if @place_block.save
        format.html { redirect_to admin_event_place_block_url(@event, @place_block), notice: "Place block was successfully created." }
        format.json { render :show, status: :created, location: @place_block }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @place_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_place_blocks/1 or /admin_place_blocks/1.json
  def update
    respond_to do |format|
      if @place_block.update(place_block_params)
        format.html { redirect_to admin_event_place_block_url(@event, @place_block), notice: "Place block was successfully updated." }
        format.json { render :show, status: :ok, location: @place_block }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @place_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_place_blocks/1 or /admin_place_blocks/1.json
  def destroy
    @place_block.destroy!

    respond_to do |format|
      format.html { redirect_to admin_event_place_blocks_url, notice: "Place block was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_place_block
      @place_block = PlaceBlock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_block_params
      params.permit(:name, :capacity, :event_id)
    end
end
