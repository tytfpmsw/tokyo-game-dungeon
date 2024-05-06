class Front::PortalController < ApplicationController
  def index
    @events_upcoming = Event.published_event_date_asc
    @events_archived = Event.archived_event_date_desc.limit(3)
  end
end
