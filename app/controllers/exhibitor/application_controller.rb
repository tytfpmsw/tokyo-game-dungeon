class Exhibitor::ApplicationController < ApplicationController
  before_action :authenticate_exhibitor!
end
