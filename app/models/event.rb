class Event < ApplicationRecord
  has_many :exhibit_informations
  has_many :sponsorships, dependent: :destroy
  has_many :sponsors, through: :sponsorships
  has_many :event_schedules, dependent: :destroy
  has_many :floors, through: :event_schedules
  has_many :place_blocks, through: :floors
  has_many :exhibit_information_places, through: :exhibit_informations

  validates :name, presence: true
  validates :url_subdirectory, presence: true, uniqueness: true, format: { with: /\A[a-z0-9_\-]+\z/ }
  validates :location, presence: true

  validate :exhibit_submit_period_is_valid, if: -> { exhibit_submit_start_at.present? && exhibit_submit_end_at.present? }

  mount_uploader :logo_image, EventLogoImageUploader
  mount_uploader :main_image, EventMainImageUploader
  mount_uploader :reflection_image, ReflectionImageUploader

  enum :status, { unpublished: 0, published: 1, archived: 2 }, _prefix: true
  enum :location, { undecided: 0, hamamatsu_tsbc: 1 }, _prefix: true

  scope :first_day_asc, -> { joins(:event_schedules).order(Arel.sql('event_schedules.start_at')) }
  scope :first_day_desc, -> { joins(:event_schedules).order(Arel.sql('event_schedules.start_at DESC')) }
  scope :published_event_date_asc, -> { where(status: :published).first_day_asc }
  scope :archived_event_date_desc, -> { where(status: :archived).first_day_desc }

  def all_day_has_floors?
    event_schedules.all?(&:has_floors?)
  end
  
  private
    def exhibit_submit_period_is_valid
      if exhibit_submit_start_at >= exhibit_submit_end_at
        errors.add(:exhibit_submit_start_at, I18n.t('errors.models.event.end_at_must_be_after_start_at'))
      end  
    end
end
