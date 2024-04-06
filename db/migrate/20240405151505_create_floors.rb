class CreateFloors < ActiveRecord::Migration[7.1]
  def change
    create_table :floors do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name, null: false
      t.string :image

      t.timestamps
    end

    remove_reference :place_blocks, :event, null: false, foreign_key: true
  end
end
