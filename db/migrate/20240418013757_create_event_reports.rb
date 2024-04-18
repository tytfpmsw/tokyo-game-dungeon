class CreateEventReports < ActiveRecord::Migration[7.1]
  def change
    drop_table :event_interviews

    create_table :event_reports do |t|
      t.references :event, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url

      t.timestamps
    end
  end
end
