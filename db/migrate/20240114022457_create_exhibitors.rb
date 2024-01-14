class CreateExhibitors < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibitors do |t|
      t.string :name, null: false
      t.string :circle_name, null: false
      t.references :place_block_master, foreign_key: true
      t.integer :place_number

      t.timestamps
    end
  end
end
