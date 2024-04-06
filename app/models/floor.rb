class Floor < ApplicationRecord
  belongs_to :event
  has_many :place_blocks, dependent: :destroy

  validates :name, presence: true

  mount_uploader :image, FloorImageUploader
end
