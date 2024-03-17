class ChangePlaceBlocksColumnNames < ActiveRecord::Migration[7.1]
  def change
    rename_column :place_blocks, :block_name, :name
    rename_column :place_blocks, :max_number, :capacity
  end
end
