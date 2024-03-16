class EventMaster < ApplicationRecord
    has_many :place_block_masters
    has_many :exhibit_permissions
end
