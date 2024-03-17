class Admin::PlaceBlocksController < ApplicationController

    before_action :authenticate_administrator!
    
end
