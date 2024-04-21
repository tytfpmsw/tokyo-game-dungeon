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
    @floor = Floor.new(name: floor_params[:floor][:name], event_schedule: @event_schedule)

    if @floor.save
      flash.now.notice = "フロアを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @floor = Floor.find(params[:id])

    if @floor.update(name: floor_params[:floor][:name])
      flash.now.notice = "フロアを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @floor = Floor.find(params[:id])
    @floor.destroy!
    flash.now.notice = "フロアを削除しました。"
  end

  private

    def set_event_schedule
      @event_schedule = EventSchedule.find(params[:event_schedule_id])
    end

    def floor_params
      params.permit(:event_schedule, floor: [ :name ])
    end
end
