class CreatePlaceBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :place_blocks do |t|
      t.string :block_name, null: false
      t.integer :max_number, null: false
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
    add_reference :exhibit_informations, :place_block, foreign_key: true

    drop_table :place_block_masters
    remove_column :exhibit_informations, :place_block_master_id
  end
end
