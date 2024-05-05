class Exhibitor::EventsController < Exhibitor::ApplicationController

  def index
    @events = Event.exhibitor_registered(current_exhibitor).in_submit_period.published_event_date_asc
  end

  def show
    @event = Event.find_by(url_subdirectory: params[:url_subdirectory])
    unless @event.exhibitor_registered?(current_exhibitor) && @event.in_submit_period?
      redirect_to exhibitor_root_path
      return
    end
    @exhibit_submission = ExhibitSubmission.find_by(exhibit_information: ExhibitInformation.find_by(event: @event, exhibitor: current_exhibitor))
  end
end
