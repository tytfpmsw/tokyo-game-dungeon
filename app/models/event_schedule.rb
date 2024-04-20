class EventSchedule < ApplicationRecord
  belongs_to :event

  has_many :floor, dependent: :destroy

  validates :event, presence: true 
  validates :start_at, presence: true
  validates :end_at, presence: true

  validate :start_at_should_be_before_end_at
  validate :start_at_and_end_at_should_be_same_day

  def has_floor?
    floor.present?
  end

  private 
    def start_at_should_be_before_end_at
      if start_at >= end_at
        errors.add(:start_at, 'は終了日時よりも前に設定してください')
      end
    end
    
    def start_at_and_end_at_should_be_same_day
      if start_at.to_date != end_at.to_date
        errors.add(:start_at, 'と終了日時は同じ日に設定してください')
      end
    end

    # すでに同じeventに登録されている他のevent_scheduleのstart_atより後であること
    def start_at_should_be_after_other_event_schedule
      if event.event_schedule.where.not(id: id).where('start_at >= ?', start_at).exists?
        errors.add(:start_at, 'は他の日程よりも後に設定してください')
      end
    end
end
