class ExhibitInformation < ApplicationRecord
  belongs_to :exhibitor

  def copy_image_from_exhibit_submission(submission_image_path)
    file_name = File.basename(submission_image_path)
    dest = Rails.root.join('app', 'assets', 'images', 'exhibit_informations', 'image', id.to_s)
    new_file_path = dest.join(file_name)
    image_tag_path = 'exhibit_informations/image/' + id.to_s + '/' + file_name
    if File.exist?(dest)
      FileUtils.remove(dest.glob('*'))
    else
      FileUtils.mkdir_p(dest)
    end
    FileUtils.cp(submission_image_path, new_file_path)
    self.image = image_tag_path
  end
end
