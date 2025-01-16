class Front::PortalController < ApplicationController
  def index
    @events_upcoming = Event.published
    @events_archived = Event.archived.limit(3)
  end
end
