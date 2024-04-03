class Sponsor < ApplicationRecord
  has_many :sponsorships, dependent: :destroy
  has_many :events, through: :sponsorships

  validates :name, presence: true
  # urlのバリデーション
  validates :url, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true

  mount_uploader :image, SponsorImageUploader
end
