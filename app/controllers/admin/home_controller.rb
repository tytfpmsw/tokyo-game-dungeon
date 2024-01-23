class Admin::HomeController < ApplicationController

  def index
    @exhibit_submissions = ExhibitSubmission.where(status: :submitted)
  end
end
