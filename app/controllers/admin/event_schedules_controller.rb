class Admin::EventSchedulesController < Admin::ApplicationController

  before_action :set_event, only: %i[index new create]
  before_action :set_event_from_schedule, only: %i[destroy]

  def index
    @event_schedules = EventSchedule.where(event_id: @event.id)
  end

  def show
    @event_schedule = EventSchedule.find(params[:id])
  end

  def new
    @event_schedule = EventSchedule.new
  end

  def edit
    @event_schedule = EventSchedule.find(params[:id])
  end

  def create
    @event_schedule = EventSchedule.new(event_schedule_params)
    @event_schedule.event = @event

    if @event_schedule.save
      flash.now.notice = "開催日を追加しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @event_schedule = EventSchedule.find(params[:id])

    if @event_schedule.update(event_schedule_params)
      flash.now.notice = "開催日を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event_schedule = EventSchedule.find(params[:id])
    if @event_schedule.destroy
      flash.now.notice = "開催日を削除しました。"
    else
      # まだフラッシュは表示されない
      flash.alert = "開催日を削除できません。"
      redirect_to admin_event_event_schedules_path(@event)
    end
  end

  private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_event_from_schedule
      @event = EventSchedule.find(params[:id]).event
    end

    def event_schedule_params
      params.require(:event_schedule).permit(:start_at, :end_at)
    end
end
