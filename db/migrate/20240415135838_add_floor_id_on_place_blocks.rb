class AddFloorIdOnPlaceBlocks < ActiveRecord::Migration[7.1]
  def change
    add_reference :place_blocks, :floor, null: false, foreign_key: true, after: :id
  end
end
