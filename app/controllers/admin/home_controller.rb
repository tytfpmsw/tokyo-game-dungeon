class Admin::HomeController < Admin::ApplicationController

  before_action :authenticate_administrator!

  def index
    @exhibit_submissions = ExhibitSubmission.where(status: :submitted)
  end
end
