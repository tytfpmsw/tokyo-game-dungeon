class AddOriginalWork < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_informations, :original_work, :string, after: :image
    add_column :exhibit_submissions, :original_work, :string, after: :image
  end
end
