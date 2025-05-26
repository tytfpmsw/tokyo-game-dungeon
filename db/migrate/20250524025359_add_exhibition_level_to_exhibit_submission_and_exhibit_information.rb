class AddExhibitionLevelToExhibitSubmissionAndExhibitInformation < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_submissions, :exhibition_level, :int, default:0, after: :game_engine
    add_column :exhibit_informations, :exhibition_level, :int, default:0, after: :game_engine

    add_index :exhibit_submissions, :exhibition_level
    add_index :exhibit_informations, :exhibition_level
  end
end
