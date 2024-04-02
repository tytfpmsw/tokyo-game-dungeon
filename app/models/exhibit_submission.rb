class ExhibitSubmission < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :exhibit_information

  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }

  # validates :status, presence: true
  
  def submit
    begin
      if find_by(exhibit_information: exhibit_information, exhibitor: exhibitor)
        update!(status: :submitted)
      else
        create!(status: :submitted)
      end
    rescure => e
      p e
      false
    end
  end

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
