class Exhibitor::EventsController < Exhibitor::ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by(url_subdirectory: params[:url_subdirectory])
    @exhibit_submission = ExhibitSubmission.find_by(exhibit_information: ExhibitInformation.find_by(event: @event, exhibitor: current_exhibitor))
  end
end
