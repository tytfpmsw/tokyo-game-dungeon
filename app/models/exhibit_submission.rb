class ExhibitSubmission < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :exhibit_information

  enum genre: Genre::TYPES, _prefix: true
  enum delivery_usage_scale: DeliveryUsageScale::SCALES, _prefix: true
  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }, prefix: true

  validates :exhibit_information, uniqueness: true
  validates :circle_name, length: { maximum: 50 }
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 100 }
  validates :title_url, allow_blank: true, url_format: true
  validates :steam_url, allow_blank: true, url_format: true
  validates :twitter_url, allow_blank: true, url_format: true
  validates :movie_url, allow_blank: true, url_format: true
  validates :original_work, allow_blank: true, length: { maximum: 50 }
  validates :memo, allow_blank: true, length: { maximum: 100 }
  
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
