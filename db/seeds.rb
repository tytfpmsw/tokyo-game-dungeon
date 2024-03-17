# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Administrator.find_or_create_by!(email: 'admin@example.com') do |administrator|
  administrator.password = "Abcd-1234"
end

EventMaster.find_or_create_by!(name_en: 'test_event', name_ja: 'テストイベント') do |event_master|
  event_master.name_en = 'test_event'
  event_master.name_ja = 'テストイベント'
end

PlaceBlock.find_or_create_by!(name: 'A') do |place_block|
  place_block.event_id = 1
  place_block.capacity = 10
end

Exhibitor.find_or_create_by!(email: 'test@example.com') do |exhibitor|
  exhibitor.name = 'テスト'
  exhibitor.password = "Abcd-1234"
end

Exhibitor.find_or_create_by!(email: 'test2@example.com') do |exhibitor|
  exhibitor.name = 'テスト2'
  exhibitor.password = "Abcd-1234"
end

Exhibitor.find_or_create_by!(email: 'test3@example.com') do |exhibitor|
  exhibitor.name = 'テスト3'
  exhibitor.password = "Abcd-1234"
end

Exhibitor.find_or_create_by!(email: 'test4@example.com') do |exhibitor|
  exhibitor.name = 'テスト4'
  exhibitor.password = "Abcd-1234"
end

ExhibitInformation.find_or_create_by!(exhibitor_id: 1) do |exhibit_information|
  exhibit_information.event_id = 1
  exhibit_information.circle_name = 'テストサークル1'
  exhibit_information.title = 'テスト展示物1'
  exhibit_information.description = 'テスト展示物1の説明'
  exhibit_information.movie_url = 'https://www.youtube.com/'
end
