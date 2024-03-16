class CreateEventMasters < ActiveRecord::Migration[7.1]
  def change
    create_table :event_masters do |t|
      t.string :name_en, null: false
      t.string :name_ja, null: false

      t.timestamps
    end
  end
end
