class PlaceBlock < ApplicationRecord
    belongs_to :floor
    has_many :exhibit_information_places
    has_many :exhibit_informations, through: :exhibit_information_places

    has_one :event_schedule, through: :floor
    has_one :event, through: :event_schedule
    
    validates :name, presence: true
    validates :capacity, presence: true

    def self.ransackable_attributes(auth_object = nil)
        %w[name capacity]
    end
end
