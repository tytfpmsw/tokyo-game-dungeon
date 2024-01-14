class CreateExhibitSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibit_submissions do |t|
      t.references :exhibitor, null: false, foreign_key: true
      t.string :exhibit_title
      t.text :exhibit_description
      t.text :exhibit_movie_link
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
