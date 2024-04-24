class ExhibitInformationPlace < ApplicationRecord

  belongs_to :exhibit_information
  belongs_to :place_block

  validates :exhibit_information, uniqueness: { scope: :place_block }
  validates :place_number, presence: true, uniqueness: { scope: :place_block }

  validate :event_match

  def event_match
    unless exhibit_information.event == place_block.floor.event_schedule.event
      errors.add(:place_block, 'イベントが一致しません')
    end
  end
end
