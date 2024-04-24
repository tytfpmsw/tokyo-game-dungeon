class AddIndexOnExhibitInformationPlaces < ActiveRecord::Migration[7.1]
  def change
    add_index :exhibit_information_places, [:exhibit_information_id, :place_block_id], unique: true
    add_index :exhibit_information_places, [:place_block_id, :place_number], unique: true
  end
end
