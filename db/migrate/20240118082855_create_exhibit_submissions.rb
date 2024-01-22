class CreateExhibitSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibit_submissions do |t|
      t.references :exhibitor, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :movie_url
      t.integer :status
      t.string :update_user
      t.text :update_comment

      t.timestamps
    end
  end
end
