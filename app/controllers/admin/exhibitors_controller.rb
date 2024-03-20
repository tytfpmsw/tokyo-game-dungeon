class Admin::ExhibitorsController < ApplicationController

  before_action :set_event

  def index
    @exhibitors = ExhibitInformation.where(event: @event).map(&:exhibitor)
  end

  def new
    
  end

  def create
    @exhibitor = Exhibitor.find_by(email: exhibitor_params[:email])

    # すでに登録済みかつ今回のイベントに出展権限がある場合
    if @exhibitor && ExhibitInformation.where(exhibitor: @exhibitor, event: @event).exists?
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
