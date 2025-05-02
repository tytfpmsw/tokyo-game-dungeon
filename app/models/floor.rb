class Floor < ApplicationRecord
  belongs_to :event_schedule
  has_many :place_blocks, dependent: :restrict_with_error
  has_many :exhibit_information_places, through: :place_blocks

  has_one :event, through: :event_schedule

  validates :name, presence: true

  mount_uploader :image, FloorImageUploader

  def image_url
    if Rails.env.development?
      # テスト環境ではローカルの画像を参照する
      image.url
    else
      # 本番環境ではS3の画像を参照する
      return ActionController::Base.helpers.asset_path('noimage.jpg') if image.blank?
      return S3Facade.new.get_object_url(Rails.application.config.s3_url, image)
    end
  end
end
