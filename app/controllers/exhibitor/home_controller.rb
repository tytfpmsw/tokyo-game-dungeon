class Exhibitor::HomeController < ApplicationController
  def index
    @exhibitor = Exhibitor.find_by(email: 'test@example.com')
    @exhibit_information = ExhibitInformation.find_by(exhibitor: @exhibitor)
    @exhibit_submission = ExhibitSubmission.where(exhibitor: @exhibitor).order(:created_at).last
  end
end
