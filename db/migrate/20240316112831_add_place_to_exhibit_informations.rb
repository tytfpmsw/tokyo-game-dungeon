class AddPlaceToExhibitInformations < ActiveRecord::Migration[7.1]
  def change
    add_reference :exhibit_informations, :place_block_master, foreign_key: true
    add_column :exhibit_informations, :place_number, :integer
  end
end
