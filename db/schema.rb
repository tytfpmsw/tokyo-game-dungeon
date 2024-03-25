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

ActiveRecord::Schema[7.1].define(version: 2024_03_25_115706) do
  create_table "administrators", charset: "utf8mb3", force: :cascade do |t|
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

  create_table "events", charset: "utf8mb3", force: :cascade do |t|
    t.string "name_en", null: false
    t.string "name_ja", null: false
    t.integer "status", default: 0, null: false
    t.string "logo_image"
    t.string "main_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exhibit_informations", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "exhibitor_id", null: false
    t.bigint "event_id", null: false
    t.bigint "place_block_id"
    t.integer "place_number"
    t.string "circle_name"
    t.string "title"
    t.string "description"
    t.string "movie_url"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_exhibit_informations_on_event_id"
    t.index ["exhibitor_id"], name: "index_exhibit_informations_on_exhibitor_id"
    t.index ["place_block_id"], name: "index_exhibit_informations_on_place_block_id"
  end

  create_table "exhibit_submissions", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "exhibit_information_id", null: false
    t.string "title"
    t.string "description"
    t.string "movie_url"
    t.string "image"
    t.integer "status"
    t.string "update_user"
    t.text "update_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibit_information_id"], name: "index_exhibit_submissions_on_exhibit_information_id"
  end

  create_table "exhibitors", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "discord_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_exhibitors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_exhibitors_on_reset_password_token", unique: true
  end

  create_table "place_blocks", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "name", null: false
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_place_blocks_on_event_id"
  end

  add_foreign_key "exhibit_informations", "events"
  add_foreign_key "exhibit_informations", "exhibitors"
  add_foreign_key "exhibit_informations", "place_blocks"
  add_foreign_key "exhibit_submissions", "exhibit_informations"
  add_foreign_key "place_blocks", "events"
end
