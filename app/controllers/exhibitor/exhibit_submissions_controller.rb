class Exhibitor::ExhibitSubmissionsController < ApplicationController
  def index
  end

  def new
    @exhibitor = Exhibitor.find_by(email: 'test@example.com')
    @exhibit_information = ExhibitInformation.find_by(exhibitor: @exhibitor)
    # もし@exhibit_submissionが存在しない場合は、新規作成する
    @exhibit_information ||= ExhibitInformation.new(exhibitor: @exhibitor)
  end

  def create
    @exhibitor = Exhibitor.find_by(email: 'test@example.com')
    @exhibit_submission = ExhibitSubmission.new(
      exhibit_submission_params.merge(exhibitor: @exhibitor, status: :submitted)
    )

    if @exhibit_submission.save
      redirect_to exhibitor_exhibit_submissions_path, notice: 'Exhibit submission was successfully created.'
    else
      render :new, status: :unprocessable_entity
      # フラッシュメッセージを表示する
    end
  end

  private

  def exhibit_submission_params
    params.except(
      :authenticity_token,
      :commit,
      :subdomain
      ).permit(
      :title,
      :description,
      :movie_url
      )
  end
end
