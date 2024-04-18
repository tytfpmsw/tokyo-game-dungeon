class RenameTimeColumnsOnEvents < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :publish_time, :publish_start_at
    rename_column :events, :exhibit_submit_start_time, :exhibit_submit_start_at
    rename_column :events, :exhibit_submit_end_time, :exhibit_submit_end_at
  end
end
