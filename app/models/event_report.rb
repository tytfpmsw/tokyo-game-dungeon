class EventReport < ApplicationRecord
  belongs_to :event

  validates :title, presence: true
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/
end
