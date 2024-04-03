class Admin::HomeController < Admin::ApplicationController

  def index
    @exhibit_submissions = ExhibitSubmission.where(status: :submitted)
  end
end
