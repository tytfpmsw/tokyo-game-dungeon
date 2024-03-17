class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    remove_reference :exhibit_submissions, :exhibit_informations
    add_reference :exhibit_submissions, :exhibit_information, foreign_key: true
  end
end
