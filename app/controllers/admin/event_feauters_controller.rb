class Admin::EventFeaturesController < Admin::BaseController
  before_action :set_event

  def index
    @event_features = @event.event_features
  end

  def edit
    @event_feature = @event.event_features.find(params[:id])
  end

  def update
    @event_feature = @event.event_features.find(params[:id])
    if @event_feature.update(event_feature_params)
      redirect_to admin_event_event_features_path(@event), notice: 'Event feature was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def event_feature_params
    params.require(:event_feature).permit(
      :label,
      :description,
      :image
      )
  end
end