class AddExhibitInformationsPublishTimeOnEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :exhibit_informations_publish_start_at, :datetime, after: :exhibit_submit_end_at
  end
end
