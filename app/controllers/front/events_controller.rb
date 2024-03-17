class Front::EventsController < ApplicationController
    def index
        @events = EventMasters.all
    end
    
    def show
        @event = EventMasters.find(params[:id])
    end
end
