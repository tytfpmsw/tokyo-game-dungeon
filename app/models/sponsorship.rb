class Sponsorship < ApplicationRecord
  belongs_to :event
  belongs_to :sponsor

  validates :sponsor_id, uniqueness: { scope: :event_id }
end
