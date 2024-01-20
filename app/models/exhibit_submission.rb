class ExhibitSubmission < ApplicationRecord
  belongs_to :exhibitor

  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }

  # validates :status, presence: true
  
  scope :submitted, -> { where(status: :submitted) }
end
