class ExhibitInformation < ApplicationRecord
  belongs_to :exhibitor
  belongs_to :event
  has_one :exhibit_submission, dependent: :destroy
  has_many :exhibit_information_places

  enum genre: Genre::TYPES, _prefix: true
  enum delivery_usage_scale: DeliveryUsageScale::SCALES, _prefix: true

  validates :event, uniqueness: { scope: :exhibitor }
  validates :circle_name, length: { maximum: 50 }
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 100 }
  validates :title_url, allow_blank: true, url_format: true
  validates :steam_url, allow_blank: true, url_format: true
  validates :twitter_url, allow_blank: true, url_format: true
  validates :movie_url, allow_blank: true, url_format: true
  validates :original_work, allow_blank: true, length: { maximum: 50 }
  validates :memo, allow_blank: true, length: { maximum: 100 }

  def copy_image(source_image_path)
    file_name = File.basename(source_image_path)
    dest_suffix = 'uploads/exhibit_informations/image/' + id.to_s
    dest_dir = Rails.root.join(Rails.application.config.exhibit_informations_image_root, dest_suffix)
    dest_full_path = dest_dir.join(file_name)
    # image_tagでupload以下を呼び出す際は先頭に/をつける必要がある
    image_tag_path = '/' + dest_suffix + '/' + file_name
    if File.exist?(dest_dir)
      FileUtils.remove(dest_dir.glob('*'))
    else
      FileUtils.mkdir_p(dest_dir)
    end
    FileUtils.cp(source_image_path, dest_full_path)
    self.image = image_tag_path
  end
end
