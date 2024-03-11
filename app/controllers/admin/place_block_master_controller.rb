class Admin::PlaceBlockMasterController < ApplicationController

    before_action :authenticate_administrator!
    
end
