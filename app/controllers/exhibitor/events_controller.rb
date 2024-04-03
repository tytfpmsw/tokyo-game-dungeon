class Exhibitor::EventsController < Exhibitor::ApplicationController

  before_action :set_event

  def index
    @events = Event.all
  end

  def show
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
