class ResequenceColumns < ActiveRecord::Migration[7.1]
  def change
    remove_reference :exhibit_informations, :event, null: false, foreign_key: true
    add_reference :exhibit_informations, :event, null: false, foreign_key: true, after: :exhibitor_id
    remove_column :exhibit_informations, :image, :string
    add_column :exhibit_informations, :image, :string, after: :movie_url
    add_column :exhibit_informations, :circle_name, :string, after: :event_id
    remove_reference :exhibit_informations, :place_block, null: false, foreign_key: true
    add_reference :exhibit_informations, :place_block, foreign_key: true, after: :event_id
    remove_column :exhibit_informations, :place_number, :integer
    add_column :exhibit_informations, :place_number, :integer, after: :place_block_id

    remove_column :exhibit_submissions, :image, :string
    add_column :exhibit_submissions, :image, :string, after: :movie_url
    remove_reference :exhibit_submissions, :exhibit_information, null: false, foreign_key: true
    add_reference :exhibit_submissions, :exhibit_information, null: false, foreign_key: true, first: true

    remove_reference :place_blocks, :event, null: false, foreign_key: true
    add_reference :place_blocks, :event, null: false, foreign_key: true, first: true
  end
end
