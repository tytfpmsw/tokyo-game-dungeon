class Sponsor < ApplicationRecord
  has_many :sponsorships, dependent: :restrict_with_error
  has_many :events, through: :sponsorships

  validates :name, presence: true
  # urlのバリデーション
  validates :url, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true

  mount_uploader :image, SponsorImageUploader

  scope :sponsorships, ->(event) { where(id: Sponsorship.where(event_id: event.id).map(&:sponsor_id)) }
  scope :not_sponsorships, ->(event) { where.not(id: Sponsorship.where(event: event).map(&:sponsor_id)) }

  def self.ransackable_attributes(auth_object = nil)
    %w[name url]
  end
end
