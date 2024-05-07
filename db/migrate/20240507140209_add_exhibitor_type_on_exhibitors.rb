class AddExhibitorTypeOnExhibitors < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibitors, :exhibitor_type, :integer, default: 0, null: false, after: :discord_name
  end
end
