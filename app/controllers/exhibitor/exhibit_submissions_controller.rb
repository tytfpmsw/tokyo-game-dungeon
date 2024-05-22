class Exhibitor::ExhibitSubmissionsController < Exhibitor::ApplicationController

  before_action :set_event, only: %i[index new edit]
  before_action :set_event_by_id, only: %i[create update]
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
    @exhibit_submission.status = ExhibitSubmission.statuses[:submitted]

    unless @exhibit_submission.save
      render :new, status: :unprocessable_entity
      return
    end

    redirect_to exhibitor_event_path(@event.url_subdirectory), notice: '出展情報を提出しました。'
  end

  def edit
    @exhibit_submission = ExhibitSubmission.find_by(exhibit_information: @exhibit_information)
    if @exhibit_submission.status_submitted?
      redirect_to exhibitor_event_path(@event.url_subdirectory), alert: '現在審査中です。審査が終了するまでお待ちください。'
    end
  end

  def update
    @exhibit_submission = ExhibitSubmission.find_by(exhibit_information: @exhibit_information)

    if @exhibit_submission.status_submitted?
      redirect_to exhibitor_event_path(@event), alert: '現在審査中です。審査が終了するまでお待ちください。'
    end

    if @exhibit_submission.update(
      circle_name: exhibit_submission_params[:circle_name],
      title: exhibit_submission_params[:title],
      genre: exhibit_submission_params[:genre],
      description: exhibit_submission_params[:description],
      title_url: exhibit_submission_params[:title_url],
      twitter_url: exhibit_submission_params[:twitter_url],
      steam_app_id: exhibit_submission_params[:steam_app_id],
      is_vr: exhibit_submission_params[:is_vr],
      movie_url: exhibit_submission_params[:movie_url],
      image: exhibit_submission_params[:image],
      original_work: exhibit_submission_params[:original_work],
      memo: exhibit_submission_params[:memo],
      delivery_usage_scale: exhibit_submission_params[:delivery_usage_scale],
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

  def set_event_by_id
    # すごくトリッキーだが、createとupdateの際はform_withの制約上
    # event.url_subdirectoryの部分にidが入ってしまうためこうしている
    @event = Event.find(params[:event_url_subdirectory])
  end

  def set_exhibitor
    @exhibitor = current_exhibitor
  end

  def set_exhibit_information
    @exhibit_information = ExhibitInformation.find_by(event: @event, exhibitor: current_exhibitor)
  end

  def return_to_exhibitor_root_if_exhibitor_can_not_submit
    unless @event.exhibitor_registered?(current_exhibitor) && @event.in_submit_period?
      redirect_to exhibitor_root_path, status: :forbidden, alert: '出展情報を提出できません。'
      return
    end
  end

  def exhibit_submission_params
    params.except(
      :authenticity_token,
      :commit,
      :subdomain)
      .require(:exhibit_submission)
      .permit(
      :circle_name,
      :title,
      :genre,
      :description,
      :title_url,
      :twitter_url,
      :steam_app_id,
      :is_vr,
      :movie_url,
      :image,
      :original_work,
      :memo,
      :delivery_usage_scale,
      )
  end
end
