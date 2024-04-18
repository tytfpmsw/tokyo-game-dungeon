class Event < ApplicationRecord
    has_many :exhibit_informations
    has_many :sponsorships, dependent: :destroy
    has_many :sponsors, through: :sponsorships
    has_many :floors, dependent: :destroy

    validates :name, presence: true
    validates :url_subdirectory, presence: true, uniqueness: true, format: { with: /\A[a-z0-9_\-]+\z/ }
    validates :location, presence: true

    mount_uploader :logo_image, EventLogoImageUploader
    mount_uploader :main_image, EventMainImageUploader
    mount_uploader :reflection_image, ReflectionImageUploader

    enum :status, { unpublished: 0, published: 1, archived: 2 }, _prefix: true
    enum :location, { undecided: 0, hamamatsu_tsbc: 1 }, _prefix: true

    scope :accepting_submissions, -> { where(status: :accepting_submissions) }

    def accepting_submissions?
        status == 'accepting_submissions'
    end

    def closed?
        status == 'closed'
    end
end
