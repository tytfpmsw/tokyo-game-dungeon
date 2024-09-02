class RemoveIndexOnExhibitInformationPlaces < ActiveRecord::Migration[7.1]
  def change
    remove_index :exhibit_information_places, column: [:place_block_id, :place_number]
  end
end
