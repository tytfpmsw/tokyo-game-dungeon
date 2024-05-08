class AddIsVr < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_informations, :is_vr, :boolean, default: false, null: false, after: :description
    add_column :exhibit_submissions, :is_vr, :boolean, default: false, null: false, after: :description
  end
end
