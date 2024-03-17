class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name_en, null: false
      t.string :name_ja, null: false

      t.timestamps
    end
    add_reference :exhibit_informations, :event, foreign_key: true
    add_reference :exhibit_permissions, :event, foreign_key: true

    drop_table :event_masters
    remove_column :exhibit_informations, :event_master_id
    remove_column :exhibit_permissions, :event_master_id
  end
end
