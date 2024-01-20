class Exhibitor::ExhibitSubmissionsController < ApplicationController
  def index
  end

  def new
    @exhibit_submission = ExhibitSubmission.new
  end

  def create
    @exhibit_submission = ExhibitSubmission.new(exhibit_submission_params)
    @exhibit_submission.exhibitor = Exhibitor.find_by(email: 'test@example.com')
    @exhibit_submission.status = :submitted

    if @exhibit_submission.save
      redirect_to exhibitor_exhibit_submissions_path, notice: 'Exhibit submission was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def exhibit_submission_params
    params.permit(:exhibit_title, :exhibit_description, :exhibit_movie_url)
  end
end
