class EventSchedule < ApplicationRecord
  belongs_to :event

  validates :event, presence: true 
  validates :start_at, presence: true
  validates :end_at, presence: true

  validate :start_at_should_be_before_end_at
  validate :start_at_and_end_at_should_be_same_day

  private 
    def start_at_should_be_before_end_at
      if start_at >= end_at
        errors.add(:start_at, 'は終了日時よりも前に設定してください')
      end
    end
    
    # start_atとend_atは同じ日であることを検証する
    def start_at_and_end_at_should_be_same_day
      if start_at.to_date != end_at.to_date
        errors.add(:start_at, 'と終了日時は同じ日に設定してください')
      end
    end
  
end
