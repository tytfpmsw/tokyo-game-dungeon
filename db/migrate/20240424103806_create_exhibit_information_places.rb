class CreateExhibitInformationPlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibit_information_places do |t|
      t.references :exhibit_information, null: false, foreign_key: true
      t.references :place_block, null: false, foreign_key: true
      t.integer :place_number, null: false

      t.timestamps
    end

    remove_reference :exhibit_informations, :place_block, index: true
    remove_column :exhibit_informations, :place_number, :integer
  end
end
