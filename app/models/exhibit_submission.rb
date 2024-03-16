class ExhibitSubmission < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :exhibit_information

  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }

  # validates :status, presence: true
  
  scope :submitted, -> { where(status: :submitted) }
end
