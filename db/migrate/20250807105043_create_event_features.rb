class CreateEventFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :event_features do |t|
      t.string :label
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
