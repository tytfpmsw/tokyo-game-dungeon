class AddColumnsOnExhibitTable < ActiveRecord::Migration[7.1]
  def change
    add_column :exhibit_informations, :title_url, :text, after: :description
    add_column :exhibit_informations, :steam_url, :text, after: :title_url
    add_column :exhibit_informations, :twitter_url, :text, after: :steam_url
    add_column :exhibit_informations, :memo, :text, after: :original_work
    add_column :exhibit_informations, :delivery_usage_scale, :integer, after: :memo

    add_column :exhibit_submissions, :title_url, :text, after: :description
    add_column :exhibit_submissions, :steam_url, :text, after: :title_url
    add_column :exhibit_submissions, :twitter_url, :text, after: :steam_url
    add_column :exhibit_submissions, :memo, :text, after: :original_work
    add_column :exhibit_submissions, :delivery_usage_scale, :integer, after: :memo
  end
end
