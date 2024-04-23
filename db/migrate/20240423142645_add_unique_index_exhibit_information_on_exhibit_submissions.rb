class AddUniqueIndexExhibitInformationOnExhibitSubmissions < ActiveRecord::Migration[7.1]
  def change
    change_table :exhibit_submissions, bulk: true do |t|
      t.remove_foreign_key :exhibit_informations
      t.remove_index :exhibit_information_id
      t.index :exhibit_information_id, unique: true
      t.foreign_key :exhibit_informations, on_delete: :cascade
    end
  end
end
