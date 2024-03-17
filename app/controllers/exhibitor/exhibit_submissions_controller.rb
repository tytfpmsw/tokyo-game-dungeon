class Exhibitor::ExhibitSubmissionsController < ApplicationController

  before_action :authenticate_exhibitor!

  def index
  end

  def new
    @exhibitor = current_exhibitor
    @exhibit_information = ExhibitInformation.find_by(exhibitor: @exhibitor)
    # もし@exhibit_submissionが存在しない場合は、新規作成する
    @exhibit_information ||= ExhibitInformation.new(exhibitor: @exhibitor)
  end

  def create
    @exhibitor = current_exhibitor
    @exhibit_information = ExhibitInformation.find_by(exhibitor: @exhibitor)
    @exhibit_submission = ExhibitSubmission.new(
      exhibit_submission_params.merge(exhibit_information_id: @exhibit_information.id, status: :submitted)
    )

    if @exhibit_submission.save
      redirect_to exhibitor_root_path, notice: 'Exhibit submission was successfully created.'
    else
      render :new, status: :unprocessable_entity
      # TODO: フラッシュメッセージを表示する
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
      :movie_url,
      :image
      )
  end
end
