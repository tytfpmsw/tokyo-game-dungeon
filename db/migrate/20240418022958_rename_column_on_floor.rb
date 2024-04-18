class RenameColumnOnFloor < ActiveRecord::Migration[7.1]
  def change
    remove_reference :floors, :event_schedules
    add_reference :floors, :event_schedule, null: false, foreign_key: true, after: :id
  end
end
