class Exhibitor::ExhibitSubmissionsController < ApplicationController

  before_action :authenticate_exhibitor!
  before_action :set_event

  def index
    @submission = ExhibitSubmission.where(exhibit_information: ExhibitInformation.where(event: @event, exhibitor: current_exhibitor))
  end

  def new
    @exhibitor = current_exhibitor
    @exhibit_information = ExhibitInformation.find_by(event: @event, exhibitor: @exhibitor)
  end

  def create
    @exhibitor = current_exhibitor
    @exhibit_information = ExhibitInformation.find_by(event: @event, exhibitor: @exhibitor)
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

  def set_event
    @event = Event.find(params[:event_id])
  end

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
