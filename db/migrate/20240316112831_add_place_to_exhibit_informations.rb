class AddPlaceToExhibitInformations < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_informations, :place_number, :integer
  end
end
