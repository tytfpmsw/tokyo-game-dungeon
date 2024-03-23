class Exhibitor::EventsController < ApplicationController

  before_action :authenticate_exhibitor!

  def index
    @events = Event.all
  end

  def show
  end
end
