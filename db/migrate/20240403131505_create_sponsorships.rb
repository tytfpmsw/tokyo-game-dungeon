class CreateSponsorships < ActiveRecord::Migration[7.1]
  def change
    create_table :sponsorships do |t|
      t.references :event, null: false, foreign_key: true
      t.references :sponsor, null: false, foreign_key: true

      t.timestamps
    end
    add_index :sponsorships, [:event_id, :sponsor_id], unique: true
  end
end
