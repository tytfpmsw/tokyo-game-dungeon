class CreateSponsors < ActiveRecord::Migration[7.1]
  def change
    create_table :sponsors do |t|
      t.string :name, null: false
      t.string :image
      t.string :url

      t.timestamps
    end
  end
end
