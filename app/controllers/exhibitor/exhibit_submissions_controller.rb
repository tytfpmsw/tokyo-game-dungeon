class Exhibitor::ExhibitSubmissionsController < ApplicationController

  before_action :authenticate_exhibitor!
  before_action :set_event
  before_action :set_exhibit_information
  before_action :set_exhibitor

  def index
    @submission = ExhibitSubmission.where(exhibit_information: ExhibitInformation.where(event: @event, exhibitor: current_exhibitor))
  end

  def new
    @exhibit_submission = ExhibitSubmission.find_by(exhibit_information: @exhibit_information)
    if @exhibit_submission
      redirect_to edit_exhibitor_event_exhibit_submission_path(@event, @exhibit_submission)
    end
  end

  def create
    if @exhibit_information.nil?
      render :new, status: :unprocessable_entity
      flash.now.alert = '出展情報が見つかりませんでした。'
      return
    end

    # @exhibit_submission = ExhibitSubmission.find_by(
    #   exhibit_submission_params.merge(exhibit_information_id: @exhibit_information.id, status: :submitted)
    # )
  
    @exhibit_submission = ExhibitSubmission.new(exhibit_submission_params.merge(exhibit_information_id: @exhibit_information.id, status: :submitted))

    begin
      if @exhibit_submission
        @exhibit_submission.update(status: :submitted)
      else
        @exhibit_submission = ExhibitSubmission.new(exhibit_submission_params.merge(exhibit_information_id: @exhibit_information.id, status: :submitted))
        @exhibit_submission.save
      end
    rescue
      render :new, status: :unprocessable_entity
      flash.now.alert = '提出情報の作成に失敗しました。'
    end

    redirect_to exhibitor_root_path, notice: 'Exhibit submission was successfully created.'
  end

  def edit
    @exhibit_submission = ExhibitSubmission.find(params[:id])
  end

  def update
    @exhibit_submission = ExhibitSubmission.find(params[:id])

    if @exhibit_submission.update(exhibit_submission_params)
      redirect_to exhibitor_root_path, notice: '提出情報を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_exhibitor
    @exhibitor = current_exhibitor
  end

  def set_exhibit_information
    @exhibit_information = ExhibitInformation.find_by(event: @event, exhibitor: current_exhibitor)
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
