class Admin::ExhibitInformationsController < Admin::ApplicationController

  before_action :set_event

  def index
    if params[:q_dynamic].present?
      field = params[:q_dynamic][:field]
      matcher = params[:q_dynamic][:matcher]
      keyword = params[:q_dynamic][:keyword]

      query_key = "#{field}_#{matcher}"
      @q = @event.exhibit_informations.ransack(query_key => keyword)
    else
      @q = @event.exhibit_informations.ransack(params[:q])
    end

    @exhibit_informations = @q.result(distinct: true)
  end

  # newとcreateについては、イベントにExhibitorを紐づけた際に
  # ExhibitInformationが作成されるためここにはない

  def edit
    @exhibit_information = @event.exhibit_informations.find(params[:id])

    if @exhibit_information.exhibit_submission.status_submitted?
      @exhibit_informations = @event.exhibit_informations
      redirect_to admin_event_exhibit_informations_path(@event), status: :unprocessable_entity, alert: '現在審査中です。先に審査を完了してください。'
      return
    end
  end

  def update
    # ExhibitInformation.imageにuploaderをマウントしてしまうと
    # ExhibitSubmissionからコピーした際にimageカラムにCarrierwaveのオブジェクトが保存されず
    # 画像を参照できなくなってしまうので、ExhibitInformationにuploaderはマウントしない。
    # そのため、admin画面からでも直接ExhibitInformationは編集せず、ExhibitSubmissionを経由する。
    # Carrierwaveの画像を他モデルにコピーできる方法がわかれば修正する。
     
    # turbo_streamで置き換えるために@exhibit_informationを保持する必要がある
    @exhibit_information = @event.exhibit_informations.find(params[:id])
    @exhibit_submission = @exhibit_information.exhibit_submission

    if @exhibit_submission.status_submitted?
      redirect_to admin_event_exhibit_informations_path(@event), alert: '現在審査中です。先に審査を完了してください。'
      return
    end

    if @exhibit_submission.update(exhibit_information_params.merge(status: :submitted))      
      flash.now.notice = '出展情報を申請しました。承認することで反映されます。'
    else
      render :edit
    end
  end

  private

  def exhibit_information_params
    params.require(:exhibit_information).permit(
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
      :highlight,
      :game_engine,
      :exhibition_level,
      )
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
