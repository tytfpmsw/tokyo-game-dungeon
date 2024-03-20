class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    add_reference :exhibit_submissions, :exhibit_information, foreign_key: true
  end
end
