class ExhibitSubmission < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :exhibit_information

  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }

  # validates :status, presence: true
  
  def self.submitted(event)
    ExhibitSubmission.joins(:exhibit_information).where(exhibit_informations: { event_id: event.id }, status: :submitted)
  end

  def approved
    
  end

  def approve!
    update!(status: :approved)
  end

  def reject!
    update!(status: :rejected)
  end
end
