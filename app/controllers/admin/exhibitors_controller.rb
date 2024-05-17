class Admin::ExhibitorsController < Admin::ApplicationController

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
    begin
      @exhibitor = Exhibitor.find_by(email: exhibitor_params[:email])

      # すでに登録済みかつ今回のイベントに出展権限がある場合
      if @exhibitor && ExhibitInformation.where(exhibitor: @exhibitor, event: @event).exists?
        render :new, status: :unprocessable_entity
        flash.now.alert = "すでに登録済みです。" and return
      end

      # 過去に出展がない場合exhibitorを新規作成
      unless @exhibitor
        @init_password = SecureRandom.hex(4)
        @exhibitor = Exhibitor.new(
          email: params[:email],
          name: params[:name],
          discord_name: params[:discord_name],
          exhibitor_type: params[:exhibitor_type],
          password: @init_password,
          password_confirmation: @init_password)
        @exhibitor.save!
        @exhibitor = Exhibitor.find_by(email: params[:email])
        ExhibitorMailer.exhibitor_registered_email(params[:email], @event.name, @init_password).deliver_now
      else
        # 登録されていてもシステム移行前のイベントの場合は管理側が登録したものなので、あらためてパスワードを通知する
        if @exhibitor.exhibit_informations.present? && @exhibitor.exhibit_informations.maximum(:event_id) <= Rails.configuration.app.event_id[:before_migrate][:max]
          @init_password = SecureRandom.hex(4)
          @exhibitor.update!(
            name: params[:name],
            discord_name: params[:discord_name],
            exhibitor_type: params[:exhibitor_type],
            password: @init_password,
            password_confirmation: @init_password)
          ExhibitorMailer.exhibitor_registered_email(@exhibitor.email, @event.name, @init_password).deliver_now
        else
          # 移行後に登録されている場合はそのままパスワードを使いたいので他項目の更新のみ
          @exhibitor.update!(
            name: params[:name],
            discord_name: params[:discord_name],
            exhibitor_type: params[:exhibitor_type])
          ExhibitorMailer.event_registered_email(@exhibitor.email, @event.name).deliver_now
        end
      end

      # 空の出展情報を作成する
      @exhibit_information = ExhibitInformation.new(exhibitor: @exhibitor, event: @event)
      @exhibit_information.save!

      if @init_password
        additional_message = "初期パスワードは#{@init_password}です。"
        flash.now.notice = "出展者を登録しました。" + additional_message
        return  
      end
      flash.now.notice = "出展者を登録しました。"

    rescue => e
      render :new, status: :unprocessable_entity
      flash.now.alert = "処理に失敗しました。 + #{e.message}"      
    end
  end

  def edit
    @exhibitor = Exhibitor.find(params[:id])
  end
  
  def update
    @exhibitor = Exhibitor.find(params[:id])
    if @exhibitor.update(email: params[:email], name: params[:name], discord_name: params[:discord_name], exhibitor_type: params[:exhibitor_type])
      flash.now.notice = "出展者情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
      flash.now.alert = "入力内容に誤りがあります。"
    end
  end

  def destroy
    @exhibit_information = ExhibitInformation.find_by(exhibitor_id: params[:id], event_id: @event.id)
    @exhibit_information.destroy!
    # turbo_streamで動的に削除する対象として@exhibitorを指定
    @exhibitor = Exhibitor.find(params[:id])
    flash.now.notice = "出展権限を削除しました。"
  end

  def regenerate_password
    @exhibitor = Exhibitor.find(params[:id])
    @init_password = @exhibitor.regenerate_password
    flash.now.notice = "#{@exhibitor.name}さんのパスワードを再設定しました。新規パスワードは'#{@init_password}'です。"
    # TODO: メール送信
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
        :discord_name,
        :exhibitor_type,
        :event_id)
  end
end
