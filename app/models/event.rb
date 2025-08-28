class Event < ApplicationRecord
  has_many :exhibit_informations
  has_many :sponsorships, dependent: :destroy
  has_many :sponsors, through: :sponsorships
  has_many :event_schedules, dependent: :restrict_with_error
  has_many :floors, through: :event_schedules
  has_many :place_blocks, through: :floors
  has_many :exhibit_information_places, through: :exhibit_informations
  has_many :event_event_features, dependent: :destroy
  has_many :event_features, through: :event_event_features

  validates :name, presence: true
  validates :url_subdirectory, presence: true, uniqueness: true, format: { with: /\A[a-z0-9_\-]+\z/ }
  validates :location, presence: true

  validate :exhibit_submit_period_is_valid, if: -> { exhibit_submit_start_at.present? && exhibit_submit_end_at.present? }
  validate :exhibit_informations_publish_start_at_is_valid, if: -> { exhibit_informations_publish_start_at.present? }

  mount_uploader :logo_image, EventLogoImageUploader
  mount_uploader :main_image, EventMainImageUploader
  mount_uploader :reflection_image, ReflectionImageUploader

  enum :status, { unpublished: 0, published: 1, archived: 2 }, _prefix: true
  enum :location, { undecided: 0, hamamatsu_tsbc: 1, note_place: 2 }, _prefix: true

  scope :first_day_asc, -> { joins(:event_schedules).order(Arel.sql('event_schedules.start_at')) }
  scope :first_day_desc, -> { joins(:event_schedules).order(Arel.sql('event_schedules.start_at DESC')) }
  scope :published_event_date_asc, -> { where(status: :published).first_day_asc }
  scope :archived_event_date_desc, -> { where(status: :archived).first_day_desc }
  scope :exhibitor_registered, ->(exhibitor) { joins(:exhibit_informations).where(exhibit_informations: { exhibitor: exhibitor }) }
  scope :in_submit_period, -> { where('exhibit_submit_start_at <= ? AND exhibit_submit_end_at >= ?', Time.current, Time.current) }

  def publish
    if published? || archived?
      errors.add(:status, "は既に公開されています")
      return false
    end

    if event_schedules.empty?
      errors.add(:event_schedules, "が存在しません")
      return false
    end

    update!(status: :published)
  end

  def unpublish
    update!(status: :unpublished)
  end

  def archive
    update!(status: :archived)
  end

  def all_day_has_floors?
    event_schedules.all?(&:has_floors?)
  end

  def exhibitor_registered?(exhibitor)
    exhibit_informations.exists?(exhibitor: exhibitor)
  end

  def in_submit_period?
    exhibit_submit_start_at <= Time.current && exhibit_submit_end_at >= Time.current
  end

  def logo_image_url
    if Rails.env.development?
      logo_image.url
    else
      # 本番環境ではS3の画像を参照する
      return ActionController::Base.helpers.asset_path('noimage.jpg') if logo_image.blank?
      return S3Facade.new.get_object_url(Rails.application.config.s3_url, '/uploads/event/logo_image/' + id.to_s + '/' + self[:logo_image])
    end
  end

  def main_image_url
    if Rails.env.development?
      main_image.url
    else
      # 本番環境ではS3の画像を参照する
      return ActionController::Base.helpers.asset_path('noimage.jpg') if main_image.blank?
      return S3Facade.new.get_object_url(Rails.application.config.s3_url, '/uploads/event/main_image/' + id.to_s + '/' + self[:main_image])
    end
  end
  
  private

  def exhibit_submit_period_is_valid
    if exhibit_submit_start_at >= exhibit_submit_end_at
      errors.add(:exhibit_submit_start_at, "は終了日時より前に設定してください")
    end  
  end

  def exhibit_informations_publish_start_at_is_valid
    if  exhibit_informations_publish_start_at < publish_start_at
      errors.add(:exhibit_informations_publish_start_at, "はイベント公開日時より後に設定してください")
    end
  end

  def create_defult_event_features
    3.times do
      feature = EventFeature.create(label: '', description: '', image: '')
      EventEventFeature.create(event: self, event_feature: feature)
    end
  end
end
