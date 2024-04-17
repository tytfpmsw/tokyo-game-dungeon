class Admin::FloorsController < Admin::ApplicationController
  
  def index
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @floors = Floor.where(event_id: @event.id)
    else
      redirect_to admin_events_path
    end
  end

  def show
    @floor = Floor.find(params[:id])
  end

  def new
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @floor = Floor.new
    else
      redirect_to admin_events_path
    end
  end

  def edit
    @floor = Floor.find(params[:id])
  end

  def create
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @floor = Floor.new(floor_params)
      @floor.event_id = @event.id

      if @floor.save
        flash.now.notice = "フロアを作成しました。"
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to admin_events_path
    end
  end

  def update
    @floor = Floor.find(params[:id])

    if @floor.update(floor_params)
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
    def floor_params
      params.require(:floor).permit(:name)
    end
end
