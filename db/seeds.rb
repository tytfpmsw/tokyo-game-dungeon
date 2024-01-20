# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Exhibitor.find_or_create_by!(email: 'test@example.com') do |exhibitor|
  exhibitor.name = 'テスト'
  exhibitor.circle_name = 'テストサークル'
  exhibitor.password = "Abcd-1234"
end

PlaceBlockMaster.find_or_create_by!(block_name: 'A') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'B') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'C') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'D') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'E') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'F') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'G') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'H') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'I') do |place_block_master|
  place_block_master.max_number = 10
end

PlaceBlockMaster.find_or_create_by!(block_name: 'J') do |place_block_master|
  place_block_master.max_number = 10
end
