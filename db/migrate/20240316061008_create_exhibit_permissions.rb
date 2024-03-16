class CreateExhibitPermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibit_permissions do |t|
      t.references :event_master, null: false, foreign_key: true
      t.references :exhibitor, null: false, foreign_key: true

      t.timestamps
    end
    remove_column :exhibitors, :circle_name, :string
    remove_column :exhibitors, :place_block_master_id, :integer
    remove_column :exhibitors, :place_number, :integer
    add_reference :exhibit_informations, :event_master
    add_column :exhibit_informations, :circle_name, :string
    remove_reference :exhibit_submissions, :exhibitor
    add_reference :exhibit_submissions, :exhibit_informations, foreign_key: true
    add_reference :place_block_masters, :event_master, foreign_key: true
  end
end
