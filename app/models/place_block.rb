class PlaceBlock < ApplicationRecord
    validates :name, presence: true
    validates :capacity, presence: true
    has_many :exhibit_informations

    def self.ransackable_attributes(auth_object = nil)
        %w[name capacity]
    end
end
