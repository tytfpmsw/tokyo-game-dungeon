class ExhibitPermission < ApplicationRecord
  belongs_to :event_master
  belongs_to :exhibitor
end
