class AddImageColumnsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :logo_image, :string, after: :status
    add_column :events, :main_image, :string, after: :logo_image
  end
end
