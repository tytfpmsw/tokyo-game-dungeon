# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_22_132816) do
  create_table "administrators", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "event_reports", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "title", null: false
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_reports_on_event_id"
  end

  create_table "event_schedules", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_schedules_on_event_id"
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "url_subdirectory", null: false
    t.integer "status", default: 0, null: false
    t.integer "location", default: 0, null: false
    t.string "logo_image"
    t.string "main_image"
    t.datetime "publish_start_at"
    t.datetime "exhibit_submit_start_at"
    t.datetime "exhibit_submit_end_at"
    t.datetime "exhibit_informations_publish_start_at"
    t.string "reflection_title"
    t.text "reflection_body"
    t.string "reflection_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url_subdirectory"], name: "index_events_on_url_subdirectory", unique: true
  end

  create_table "exhibit_information_places", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "exhibit_information_id", null: false
    t.bigint "place_block_id", null: false
    t.integer "place_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibit_information_id", "place_block_id"], name: "idx_on_exhibit_information_id_place_block_id_57297952ff", unique: true
    t.index ["exhibit_information_id"], name: "index_exhibit_information_places_on_exhibit_information_id"
    t.index ["place_block_id", "place_number"], name: "idx_on_place_block_id_place_number_ec8e3797d3", unique: true
    t.index ["place_block_id"], name: "index_exhibit_information_places_on_place_block_id"
  end

  create_table "exhibit_informations", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "exhibitor_id", null: false
    t.bigint "event_id", null: false
    t.string "circle_name"
    t.string "title"
    t.integer "genre", default: 0, null: false
    t.string "description"
    t.text "title_url"
    t.text "twitter_url"
    t.bigint "steam_app_id"
    t.boolean "is_vr", default: false, null: false
    t.text "movie_url"
    t.string "image"
    t.string "original_work"
    t.text "memo"
    t.integer "delivery_usage_scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_exhibit_informations_on_event_id"
    t.index ["exhibitor_id"], name: "index_exhibit_informations_on_exhibitor_id"
  end

  create_table "exhibit_submissions", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "exhibit_information_id", null: false
    t.string "circle_name"
    t.string "title"
    t.integer "genre", default: 0, null: false
    t.string "description"
    t.text "title_url"
    t.text "twitter_url"
    t.bigint "steam_app_id"
    t.boolean "is_vr", default: false, null: false
    t.text "movie_url"
    t.string "image"
    t.string "original_work"
    t.text "memo"
    t.integer "delivery_usage_scale"
    t.integer "status"
    t.string "update_user"
    t.text "update_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibit_information_id"], name: "index_exhibit_submissions_on_exhibit_information_id", unique: true
  end

  create_table "exhibitors", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "discord_name"
    t.integer "exhibitor_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_exhibitors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_exhibitors_on_reset_password_token", unique: true
  end

  create_table "floors", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "event_schedule_id", null: false
    t.string "name", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_schedule_id"], name: "index_floors_on_event_schedule_id"
  end

  create_table "place_blocks", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "floor_id", null: false
    t.string "name", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["floor_id"], name: "index_place_blocks_on_floor_id"
  end

  create_table "sponsors", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sponsorships", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "sponsor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "sponsor_id"], name: "index_sponsorships_on_event_id_and_sponsor_id", unique: true
    t.index ["event_id"], name: "index_sponsorships_on_event_id"
    t.index ["sponsor_id"], name: "index_sponsorships_on_sponsor_id"
  end

  add_foreign_key "event_reports", "events"
  add_foreign_key "event_schedules", "events"
  add_foreign_key "exhibit_information_places", "exhibit_informations"
  add_foreign_key "exhibit_information_places", "place_blocks"
  add_foreign_key "exhibit_informations", "events"
  add_foreign_key "exhibit_informations", "exhibitors"
  add_foreign_key "exhibit_submissions", "exhibit_informations", on_delete: :cascade
  add_foreign_key "floors", "event_schedules"
  add_foreign_key "place_blocks", "floors"
  add_foreign_key "sponsorships", "events"
  add_foreign_key "sponsorships", "sponsors"
end
