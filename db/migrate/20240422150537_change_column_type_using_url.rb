class ChangeColumnTypeUsingUrl < ActiveRecord::Migration[7.1]
  def change
    change_column :event_reports, :url, :text
    change_column :exhibit_informations, :movie_url, :text
    change_column :exhibit_submissions, :movie_url, :text
    change_column :sponsors, :url, :text
  end
end
