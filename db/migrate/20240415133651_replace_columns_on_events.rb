class ReplaceColumnsOnEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :name_en, :string
    rename_column :events, :name_ja, :name
    add_column :events, :publish_time, :datetime, after: :main_image
    add_column :events, :exhibit_submit_start_time, :datetime, after: :publish_time
    add_column :events, :exhibit_submit_end_time, :datetime, after: :exhibit_submit_start_time
    add_column :events, :reflection_title, :string, after: :exhibit_submit_end_time
    add_column :events, :reflection_description, :text, after: :reflection_title
  end
end
