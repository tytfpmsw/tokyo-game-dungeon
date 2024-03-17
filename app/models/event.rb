class Event < ApplicationRecord
    validates :name_en, presence: true
    validates :name_ja, presence: true
    has_many :exhibit_informations
    has_many :exhibit_permissions
end
