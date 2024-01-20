class Admin::ExhibitSubmissionsController < ApplicationController
  def index
    @exhibit_submissions = ExhibitSubmission.submitted.order(created_at: :asc)
  end

  def show
    @exhibit_submission = ExhibitSubmission.find(params[:id])
  end

  def edit
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    
  end

  def update
  end
end
