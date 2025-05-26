class AddHighlightToExhibitSubmissionAndExhibitInformation < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_submissions, :highlight, :string, after: :delivery_usage_scale
    add_column :exhibit_informations, :highlight, :string , after: :delivery_usage_scale
  end
end
