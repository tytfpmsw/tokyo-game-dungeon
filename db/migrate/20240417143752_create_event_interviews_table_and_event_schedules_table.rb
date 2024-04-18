class CreateEventInterviewsTableAndEventSchedulesTable < ActiveRecord::Migration[7.1]
  def change
    create_table :event_interviews do |t|
      t.references :event, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url

      t.timestamps
    end

    create_table :event_schedules do |t|
      t.references :event, null: false, foreign_key: true
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end

    remove_reference :floors, :event, null: false, foreign_key: true
    add_reference :floors, :event_schedules, null: false, foreign_key: true, after: :id
  end
end
