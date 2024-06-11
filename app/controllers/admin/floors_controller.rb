class Admin::FloorsController < Admin::ApplicationController
  
  before_action :set_event_schedule, only: %i[index new create]

  def index
    @floors = Floor.where(event_schedule: @event_schedule)
    @event = @event_schedule.event
  end

  def show
    @floor = Floor.find(params[:id])
  end

  def new
    @floor = Floor.new
  end

  def edit
    @floor = Floor.find(params[:id])
  end

  def create
    @floor = Floor.new(name: floor_params[:floor][:name], image: floor_params[:floor][:image], event_schedule: @event_schedule)

    if @floor.save
      flash.now.notice = "フロアを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @floor = Floor.find(params[:id])

    if @floor.update(name: floor_params[:floor][:name], image: floor_params[:floor][:image])
      flash.now.notice = "フロアを更新しました。"
    else
      @event = @floor.event_schedule.event
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @floor = Floor.find(params[:id])
    if @floor.destroy
      flash.now.notice = "フロアを削除しました。"
    else
      flash.now.alert = "フロアの削除に失敗しました。"
      @event = @floor.event_schedule.event
      @event_schedule = @floor.event_schedule
      @floors = Floor.where(event_schedule: @floor.event_schedule)
      render turbo_stream: turbo_stream.append("flashes", partial: "flash"), status: :unprocessable_entity
    end
  end

  private

    def set_event_schedule
      @event_schedule = EventSchedule.find(params[:event_schedule_id])
    end

    def floor_params
      params.permit(:event_schedule, floor: [ :name, :image ])
    end
end
