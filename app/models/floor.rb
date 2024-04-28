class Floor < ApplicationRecord
  belongs_to :event_schedule
  has_many :place_blocks, dependent: :destroy
  has_many :exhibit_information_places, through: :place_blocks

  has_one :event, through: :event_schedule

  validates :name, presence: true

  mount_uploader :image, FloorImageUploader
end
