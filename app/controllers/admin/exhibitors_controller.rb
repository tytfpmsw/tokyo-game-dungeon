class Admin::ExhibitorsController < ApplicationController

  before_action :set_event

  def index
    @exhibitPermissions = @event.exhibit_permissions
    @exhibitors = @exhibitPermissions.map(&:exhibitor)
  end

  def new
    
  end

  def create
    @exhibitor = Exhibitor.find_by(email: exhibitor_params[:email])

    # すでに登録済みの場合
    # もしexhibitor_permissionに@exhibitorと@event_masterが紐づいている場合は、エラーを返す
    if @exhibitor && ExhibitPermission.find_by(exhibitor: @exhibitor, event: @event)
      render :new, status: :unprocessable_entity
      #  TODO: フラッシュメッセージを表示する
      return
    end

    # 過去に出展がない場合exhibitorを新規作成
    unless @exhibitor
      @default_password = SecureRandom.hex(8)
      @exhibitor = Exhibitor.new(email: params[:email], name: "test", password: @default_password, password_confirmation: @default_password)
      @exhibitor.save
    end

    # 今回のイベントに出展権限を付与
    @exhibitPermission = ExhibitPermission.new(event: @event, exhibitor: @exhibitor)
    @exhibitPermission.save

    # 空の出展情報を作成する
    @exhibit_information = ExhibitInformation.new(exhibitor: @exhibitor, event: @event)
    @exhibit_information.save
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def exhibitor_params
    params.permit(:email)
  end
end
