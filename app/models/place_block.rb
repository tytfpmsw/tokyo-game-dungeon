class PlaceBlock < ApplicationRecord
    validates :name, presence: true
    validates :capacity, presence: true
    belongs_to :event
    has_many :exhibit_informations
end
