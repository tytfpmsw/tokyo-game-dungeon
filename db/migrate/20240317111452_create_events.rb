class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name_en, null: false
      t.string :name_ja, null: false

      t.timestamps
    end
    add_reference :exhibit_informations, :event, foreign_key: true
  end
end
