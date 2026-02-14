require 'csv'

class Admin::EventsController < Admin::ApplicationController

  before_action :set_event, only: %i[ show edit update publish unpublish archive export_exhibit_informations ]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(
      name: event_params[:name],
      url_subdirectory: event_params[:url_subdirectory],
      status: :unpublished,
      location: event_params[:location],
      logo_image: event_params[:logo_image],
      main_image: event_params[:main_image],
      publish_start_at: event_params[:publish_start_at],
      exhibit_submit_start_at: event_params[:exhibit_submit_start_at],
      exhibit_submit_end_at: event_params[:exhibit_submit_end_at],
      exhibit_informations_publish_start_at: event_params[:exhibit_informations_publish_start_at]
      )

      if @event.save
        redirect_to admin_event_url(@event), notice: "イベントを作成しました。"
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
    if @event.update(event_params)
      redirect_to admin_event_url(@event), notice: "イベントを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def publish
    if @event.publish
      redirect_to admin_event_url(@event), notice: 'イベントを公開しました。'
    else
      redirect_to admin_event_url(@event), alert: "#{@event.errors.full_messages.join(', ')}"
    end
  end

  def unpublish
    @event.unpublish
    redirect_to admin_event_url(@event), notice: 'イベントを非公開にしました。'
  end

  def archive
    @event.archive
    redirect_to admin_event_url(@event), notice: 'イベントをアーカイブしました。'
  end

  def export_exhibit_informations
    columns = %w[delivery_usage_scale circle_name title image description genre is_vr original_work twitter_url title_url steam_app_id movie_url memo highlight exhibition_level game_engine]
    csv = CSV.generate do |csv|
      csv << columns
      @event.exhibit_informations.find_each do |ei|
        csv << columns.map { |column| sanitize_for_csv(translated_value(ei, column)) }
      end
    end

    filename = "#{@event.name}_#{Time.current.strftime('%Y%m%d%H%M%S')}.csv"
    send_data csv, filename: filename, type: 'text/csv'
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def translated_value(record, attr)
      value = record.public_send(attr) rescue nil
    return '' if value.nil?

    result =
      # delivery_usage_scale の model.ja.yml の対応翻訳を使う
      if attr.to_s == 'delivery_usage_scale'
        return I18n.t("activerecord.attributes.delivery_usage_scale.#{value}", default: value.to_s.humanize)
      end

      # genre の model.ja.yml の対応翻訳を使う
      if attr.to_s == 'genre'
        return I18n.t("activerecord.attributes.genre.#{value}", default: value.to_s.humanize)
      end

      # exhibition_level の model.ja.yml の対応翻訳を使う
      if attr.to_s == 'exhibition_level'
        return I18n.t("activerecord.attributes.exhibition_level.#{value}", default: value.to_s.humanize)
      end

      # is_vr を "VR使用" または "" に変換する
      if attr.to_s == 'is_vr'
        return value ? 'VR使用' : ''
      end

      # imageカラムの"/uploads" をS3のURLに変換する
      if attr.to_s == 'image' && value.present?
        
        # すでにURL形式の場合はそのまま返す
        unless value =~ %r{\Ahttps?://}
          value = value.sub(%r{\A/?uploads}, "#{Rails.application.config.s3_url}/uploads")
        end
      end

    # 改行をスペースに変換してCSVに出力する
    result.to_s.gsub(/\r?\n|/, ' ').squeeze(' ').strip

    value.to_s
    end

    def sanitize_for_csv(str)
      s = str.to_s
      s = s.gsub(/\r\n?/, ' ')        # CRLF, CR, LF
      s = s.gsub(/<br\s*\/?>/i, ' ')  # <br> や <br/>
      s = s.gsub(/&nbsp;/i, ' ')      # HTML エンティティ
      s = s.gsub("\u00A0", ' ')       # NBSP
      s.gsub(/\s+/, ' ').strip
    end

    def event_params
      params
        .require(:event)
        .permit(
          :name,
          :url_subdirectory,
          :location,
          :logo_image,
          :main_image,
          :publish_start_at,
          :exhibit_submit_start_at,
          :exhibit_submit_end_at,
          :exhibit_informations_publish_start_at
          )
    end
end
