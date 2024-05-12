class AddGenreColumns < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_submissions, :genre, :integer, default: 0, null: false, after: :title
    add_column :exhibit_informations, :genre, :integer, default: 0, null: false, after: :title
  end
end
