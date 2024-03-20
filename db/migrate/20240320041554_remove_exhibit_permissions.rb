class RemoveExhibitPermissions < ActiveRecord::Migration[7.1]
  def change
    drop_table :exhibit_permissions do |t|
      t.integer "exhibitor_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "event_id"
      t.index ["event_id"], name: "index_exhibit_permissions_on_event_id"
      t.index ["exhibitor_id"], name: "index_exhibit_permissions_on_exhibitor_id"
    end
  end
end
