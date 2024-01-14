class CreatePlaceBlockMasters < ActiveRecord::Migration[7.1]
  def change
    create_table :place_block_masters do |t|
      t.string :block_name, null: false
      t.integer :max_number, null: false

      t.timestamps
    end
  end
end
