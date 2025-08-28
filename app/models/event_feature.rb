class EventFeature < ApplicationRecord
  has_many :event_event_features, dependent: :destroy
  has_many :events, through: :event_event_features

  mount_uploader :image, EventFeatureImageUploader
end
