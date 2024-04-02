class Admin::ExhibitorsController < ApplicationController

  before_action :authenticate_administrator!
  before_action :set_event

  def index
    @exhibit_informations = ExhibitInformation.where(event: @event)
    @search = Exhibitor.where(id: @exhibit_informations.pluck(:exhibitor_id)).ransack(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @exhibitors = @search.result.page(params[:page])
  end

  def show
    @exhibitor = Exhibitor.find(params[:id])
  end

  def new
    @exhibitor = Exhibitor.new
  end

  def create
    @exhibitor = Exhibitor.find_by(email: exhibitor_params[:email])

    # すでに登録済みかつ今回のイベントに出展権限がある場合
    if @exhibitor && ExhibitInformation.where(exhibitor: @exhibitor, event: @event).exists?
      render :new, status: :unprocessable_entity
      flash.now.alert = "すでに登録済みです。"
      return
    end

    # 過去に出展がない場合exhibitorを新規作成
    unless @exhibitor
      @init_password = SecureRandom.hex(8)
      # @exhibitor = Exhibitor.new(email: params[:email], name: params[:name], discord_name: params[:discord_name], password: @init_password, password_confirmation: @init_password)
      @exhibitor = Exhibitor.new(email: params[:email], name: params[:name], discord_name: params[:discord_name], password: params[:password], password_confirmation: params[:password])
      @exhibitor.save
      @exhibitor = Exhibitor.find_by(email: params[:email])
    end

    # 空の出展情報を作成する
    @exhibit_information = ExhibitInformation.new(exhibitor: @exhibitor, event: @event)
    @exhibit_information.save
    flash.now.notice = "出展者を登録しました。"
  end

  def edit
  end
  
  def update
    @exhibitor = Exhibitor.find(params[:id])
    @exhibitor.update(exhibitor_params)
    flash.now.notice = "出展者情報を更新しました。"
  end

  def destroy
    @exhibit_information = ExhibitInformation.find_by(exhibitor_id: params[:id], event_id: @event.id)
    @exhibit_information.destroy!
    # turbo_streamで動的に削除する対象として@exhibitorを指定
    @exhibitor = Exhibitor.find(params[:id])
    flash.now.notice = "出展権限を削除しました。"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def exhibitor_params
    params.except(
      :authenticity_token,
      :commit,
      :subdomain
      ).permit(
        :email, 
        :name,
        :password,
        :discord_name, 
        :event_id)
  end
end
