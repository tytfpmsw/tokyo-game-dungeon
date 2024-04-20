class Exhibitor::EventsController < Exhibitor::ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by(url_subdirectory: params[:url_subdirectory])
  end
end
