class Exhibitor::HomeController < ApplicationController

  before_action :authenticate_exhibitor!

  def index
    @exhibitor = current_exhibitor
    @events_can_submit = Event.accepting_submissions
  end
end
