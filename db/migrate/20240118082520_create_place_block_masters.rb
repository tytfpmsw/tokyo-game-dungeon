class CreatePlaceBlockMasters < ActiveRecord::Migration[7.1]
  def change
    create_table :place_block_masters do |t|
      t.string :block_name
      t.integer :max_number

      t.timestamps
    end
  end
end
