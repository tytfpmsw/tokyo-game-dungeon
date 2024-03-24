class Event < ApplicationRecord
    validates :name_en, presence: true
    validates :name_ja, presence: true
    has_many :exhibit_informations

    mount_uploader :logo_image, EventLogoImageUploader
    mount_uploader :main_image, EventMainImageUploader

    # 出展情報受付前: 0, 出展情報受付中: 1, 出展情報締切済: 2, イベント終了: 3
    enum :status, { before_accepting: 0, accepting_submissions: 1, finished_accepting: 2, closed: 3 }

    scope :accepting_submissions, -> { where(status: :accepting_submissions) }

    def accepting_submissions?
        status == 'accepting_submissions'
    end

    def closed?
        status == 'closed'
    end
end
