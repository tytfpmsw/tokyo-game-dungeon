class PlaceBlock < ApplicationRecord
    belongs_to :floor
    has_many :exhibit_information_places
    
    validates :name, presence: true
    validates :capacity, presence: true

    def self.ransackable_attributes(auth_object = nil)
        %w[name capacity]
    end
end
