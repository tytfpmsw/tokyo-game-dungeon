class Admin::ExhibitInformationsController < Admin::ApplicationController

  before_action :set_event

  def index
    @exhibit_informations = @event.exhibit_informations
  end

  # newとcreateについては、イベントにExhibitorを紐づけた際に
  # ExhibitInformationが作成されるためここにはない

  def edit
    @exhibit_information = @event.exhibit_informations.find(params[:id])
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
    if @exhibit_submission.update(exhibit_information_params.merge(status: :submitted))      
      flash.now.notice = '出展情報を申請しました。承認することで反映されます。'
    else
      render :edit
    end
  end

  private

  def exhibit_information_params
    params.require(:exhibit_information).permit(:circle_name, :title, :genre, :description, :is_vr, :movie_url, :image)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
