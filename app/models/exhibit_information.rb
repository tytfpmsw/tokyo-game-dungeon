class ExhibitInformation < ApplicationRecord
  belongs_to :exhibitor
  belongs_to :event
  # 作成時には場所は決まっていないはずなのでoptional: trueとする
  belongs_to :place_block, optional: true
  has_many :exhibit_submissions, dependent: :destroy

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
