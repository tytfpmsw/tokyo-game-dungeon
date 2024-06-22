class Admin::ExhibitSubmissionsController < Admin::ApplicationController

  before_action :set_event

  def index
    @exhibit_submissions = ExhibitSubmission.submitted(@event).order(created_at: :asc)
  end

  def show
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    @exhibit_information = ExhibitInformation.find_by(id: @exhibit_submission.exhibit_information_id)
    @exhibitor = Exhibitor.find_by(id: @exhibit_information.exhibitor_id)
  end

  def approve
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    @exhibit_information = ExhibitInformation.find_by(id: @exhibit_submission.exhibit_information_id)

    if !@exhibit_submission.image.blank?
      @exhibit_information.copy_image(@exhibit_submission.image.path)
    end
    
    @exhibit_information.circle_name = @exhibit_submission.circle_name? ? @exhibit_submission.circle_name : @exhibit_information.circle_name
    @exhibit_information.title = @exhibit_submission.title? ? @exhibit_submission.title : @exhibit_information.title
    @exhibit_information.genre = @exhibit_submission.genre? ? @exhibit_submission.genre : @exhibit_information.genre
    @exhibit_information.description = @exhibit_submission.description? ? @exhibit_submission.description : @exhibit_information.description
    @exhibit_information.title_url = @exhibit_submission.title_url
    @exhibit_information.twitter_url = @exhibit_submission.twitter_url
    @exhibit_information.steam_app_id = @exhibit_submission.steam_app_id
    @exhibit_information.is_vr = @exhibit_submission.is_vr? ? @exhibit_submission.is_vr : @exhibit_information.is_vr
    @exhibit_information.movie_url = @exhibit_submission.movie_url
    @exhibit_information.original_work = @exhibit_submission.original_work
    @exhibit_information.memo = @exhibit_submission.memo
    @exhibit_information.delivery_usage_scale = @exhibit_submission.delivery_usage_scale? ? @exhibit_submission.delivery_usage_scale : @exhibit_information.delivery_usage_scale
    # imageはcopy_imageでコピー済み
    @exhibit_information.update!(@exhibit_information.attributes)
    
    @exhibit_submission.update!(status: "approved")
    redirect_to admin_event_exhibit_informations_path, notice: '出展情報を承認しました。'
  end

  def reject
    @exhibit_submission = ExhibitSubmission.find(params[:id])
    @exhibit_submission.update!(status: "rejected")
    redirect_to admin_event_exhibit_informations_path, notice: '出展情報を却下しました。'
  end

  private 

  def set_event
    @event = Event.find(params[:event_id])
  end
end
