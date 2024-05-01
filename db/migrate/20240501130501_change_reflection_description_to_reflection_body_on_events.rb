class ChangeReflectionDescriptionToReflectionBodyOnEvents < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :reflection_description, :reflection_body
  end
end
