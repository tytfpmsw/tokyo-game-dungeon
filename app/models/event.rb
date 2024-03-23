class Event < ApplicationRecord
    validates :name_en, presence: true
    validates :name_ja, presence: true
    has_many :exhibit_informations
    has_many :exhibit_permissions

    # 出展情報受付前: 0, 出展情報受付中: 1, 出展情報締切済: 2
    enum :status, { before_accepting: 0, accepting_submissions: 1, closed: 2 }

    scope :accepting_submissions, -> { where(status: :accepting_submissions) }

    def accepting_submissions?
        status == 'accepting_submissions'
    end

    def closed?
        status == 'closed'
    end
end
