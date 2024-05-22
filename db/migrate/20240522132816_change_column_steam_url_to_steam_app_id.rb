class ChangeColumnSteamUrlToSteamAppId < ActiveRecord::Migration[7.1]
  def change
    remove_column :exhibit_informations, :steam_url, :string
    remove_column :exhibit_submissions, :steam_url, :string

    add_column :exhibit_informations, :steam_app_id, :bigint, after: :twitter_url
    add_column :exhibit_submissions, :steam_app_id, :bigint, after: :twitter_url
  end
end
