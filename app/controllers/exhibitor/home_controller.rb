class Exhibitor::HomeController < ApplicationController

  before_action :authenticate_exhibitor!

  def index
    @exhibitor = current_exhibitor
    @exhibit_information = ExhibitInformation.find_by(exhibitor: @exhibitor)
    @exhibit_submission = ExhibitSubmission.where(exhibit_information: @exhibit_information).order(:created_at).last
  end
end
