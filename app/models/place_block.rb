class PlaceBlock < ApplicationRecord
    validates :name, presence: true
    validates :capacity, presence: true
    belongs_to :event
    has_many :exhibit_informations

    def self.ransackable_attributes(auth_object = nil)
        %w[name capacity]
    end
end
