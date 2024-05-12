class ExhibitSubmission < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :exhibit_information

  enum genre: Genre::TYPES
  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }, prefix: true

  validates :exhibit_information, uniqueness: true
  validates :circle_name, length: { maximum: 25 }
  validates :title, length: { maximum: 25 }
  validates :description, length: { maximum: 255 }
  validates :movie_url, allow_blank: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :original_work, allow_blank: true, length: { maximum: 25 }
  
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

  def approve!
    update!(status: :approved)
  end

  def reject!
    update!(status: :rejected)
  end
end
