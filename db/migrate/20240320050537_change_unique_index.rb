class ChangeUniqueIndex < ActiveRecord::Migration[7.1]
  def ChangeUniqueIndex
    add_index :exhibit_informations, [:exhibitor_id, :event_id], unique: true
  end
end
