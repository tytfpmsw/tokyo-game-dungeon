class AddColumnsOnEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :url, :string, null: false, after: :name
    add_column :events, :location, :integer, default: 0, null: false, after: :status
    add_column :events, :reflection_image, :string, after: :reflection_description
    add_index :events, :url, unique: true
  end
end
