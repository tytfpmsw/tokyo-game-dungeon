class AddImageColumnToExhibitSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_submissions, :image, :string
    add_column :exhibit_informations, :image, :string
  end
end
