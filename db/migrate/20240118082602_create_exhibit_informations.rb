class CreateExhibitInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :exhibit_informations do |t|
      # 外部キー制約かつ一意制約はchange_tableでしか付与できないため、ここでは付与しない
      t.references :exhibitor, null: false
      t.string :title
      t.string :description
      t.string :movie_url

      t.timestamps
    end
    
    change_table :exhibit_informations, bulk: true do |t|
      t.foreign_key :exhibitors
    end
  end
end
