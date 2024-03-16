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

PlaceBlockMaster.find_or_create_by!(block_name: 'A') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'B') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'C') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'D') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'E') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'F') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'G') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'H') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'I') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'J') do |place_block_master|
  place_block_master.event_master_id = 1
  place_block_master.max_number = 10
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
  exhibit_information.event_master_id = 1
  exhibit_information.circle_name = 'テストサークル1'
  exhibit_information.title = 'テスト展示物1'
  exhibit_information.description = 'テスト展示物1の説明'
  exhibit_information.movie_url = 'https://www.youtube.com/'
end

ExhibitInformation.find_or_create_by!(exhibitor_id: 2) do |exhibit_information|
  exhibit_information.event_master_id = 1
  exhibit_information.circle_name = 'テストサークル2'
  exhibit_information.title = 'テスト展示物2'
  exhibit_information.description = 'テスト展示物2の説明'
  exhibit_information.movie_url = 'https://www.youtube.com/'
end

ExhibitInformation.find_or_create_by!(exhibitor_id: 3) do |exhibit_information|
  exhibit_information.event_master_id = 1
  exhibit_information.circle_name = 'テストサークル3'  
  exhibit_information.title = 'テスト展示物3'
  exhibit_information.description = 'テスト展示物3の説明'
  exhibit_information.movie_url = 'https://www.youtube.com/'
end

ExhibitInformation.find_or_create_by!(exhibitor_id: 4) do |exhibit_information|
  exhibit_information.event_master_id = 1
  exhibit_information.circle_name = 'テストサークル4'
  exhibit_information.title = 'テスト展示物4'
  exhibit_information.description = 'テスト展示物4の説明'
  exhibit_information.movie_url = 'https://www.youtube.com/'
end
