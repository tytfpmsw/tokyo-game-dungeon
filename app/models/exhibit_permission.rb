class ExhibitPermission < ApplicationRecord
  belongs_to :event
  belongs_to :exhibitor
end
