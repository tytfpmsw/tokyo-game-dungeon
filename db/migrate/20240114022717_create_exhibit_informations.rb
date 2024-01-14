class CreateExhibitInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibit_informations do |t|
      t.references :exhibitor, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.text :movie_link

      t.timestamps
    end
  end
end
