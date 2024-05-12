class Exhibitor::ExhibitSubmissionsController < Exhibitor::ApplicationController

  before_action :set_event
  before_action :set_exhibit_information
  before_action :set_exhibitor
  before_action :return_to_exhibitor_root_if_exhibitor_can_not_submit

  def index
    @exhibit_submission = ExhibitSubmission.find_by(exhibit_information: ExhibitInformation.where(event: @event, exhibitor: current_exhibitor))
  end

  def new
    @exhibit_submission = ExhibitSubmission.new
  end

  def create
    if @exhibit_information.nil?
      render :new, status: :unprocessable_entity
      flash.now.alert = '出展情報が見つかりませんでした。'
      return
    end

    @exhibit_submission = ExhibitSubmission.new(exhibit_submission_params)
    @exhibit_submission.exhibit_information = @exhibit_information

    unless @exhibit_submission.save
      render :new, status: :unprocessable_entity
      return
    end

    redirect_to exhibitor_root_path, notice: '出展情報を提出しました。'
  end

  def edit
    @exhibit_submission = ExhibitSubmission.find(params[:id])
  end

  def update
    @exhibit_submission = ExhibitSubmission.find(params[:id])

    if @exhibit_submission.update(
      circle_name: exhibit_submission_params[:circle_name],
      title: exhibit_submission_params[:title],
      genre: exhibit_submission_params[:genre],
      description: exhibit_submission_params[:description],
      is_vr: exhibit_submission_params[:is_vr],
      movie_url: exhibit_submission_params[:movie_url],
      image: exhibit_submission_params[:image],
      original_work: exhibit_submission_params[:original_work],
      status: ExhibitSubmission.statuses[:submitted]
    )
      redirect_to exhibitor_root_path, notice: '提出情報を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find_by!(url_subdirectory: params[:event_url_subdirectory])
  end

  def set_exhibitor
    @exhibitor = current_exhibitor
  end

  def set_exhibit_information
    @exhibit_information = ExhibitInformation.find_by(event: @event, exhibitor: current_exhibitor)
  end

  def return_to_exhibitor_root_if_exhibitor_can_not_submit
    unless @event.exhibitor_registered?(current_exhibitor) && @event.in_submit_period?
      redirect_to exhibitor_root_path, status: :forbidden
      return
    end
  end

  def exhibit_submission_params
    params.except(
      :authenticity_token,
      :commit,
      :subdomain
      ).permit(
      :circle_name,
      :title,
      :genre,
      :description,
      :is_vr,
      :movie_url,
      :image,
      :original_work
      )
  end
end
