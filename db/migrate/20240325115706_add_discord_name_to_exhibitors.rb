class AddDiscordNameToExhibitors < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibitors, :discord_name, :string, after: :name
  end
end
