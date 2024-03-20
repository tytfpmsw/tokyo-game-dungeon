class ChangeUniqueIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :exhibit_informations, name: "index_exhibit_informations_on_exhibitor_id"
    add_index :exhibit_informations, [:exhibitor_id, :event_id], unique: true
  end
end
