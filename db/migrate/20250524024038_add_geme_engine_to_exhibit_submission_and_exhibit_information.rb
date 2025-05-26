class AddGemeEngineToExhibitSubmissionAndExhibitInformation < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_submissions, :game_engine, :string, after: :highlight
    add_column :exhibit_informations, :game_engine, :string , after: :highlight

    add_index :exhibit_submissions, :game_engine
    add_index :exhibit_informations, :game_engine
  end
end
