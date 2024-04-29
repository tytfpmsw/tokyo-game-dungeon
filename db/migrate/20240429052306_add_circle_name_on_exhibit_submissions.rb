class AddCircleNameOnExhibitSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_submissions, :circle_name, :string, after: :exhibit_information_id
  end
end
