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

ActiveRecord::Schema[7.1].define(version: 2024_03_16_061008) do
  create_table "administrators", force: :cascade do |t|
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

  create_table "event_masters", force: :cascade do |t|
    t.string "name_en", null: false
    t.string "name_ja", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exhibit_informations", force: :cascade do |t|
    t.integer "exhibitor_id", null: false
    t.string "title"
    t.string "description"
    t.string "movie_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.integer "event_master_id"
    t.string "circle_name"
    t.index ["event_master_id"], name: "index_exhibit_informations_on_event_master_id"
    t.index ["exhibitor_id"], name: "index_exhibit_informations_on_exhibitor_id", unique: true
  end

  create_table "exhibit_permissions", force: :cascade do |t|
    t.integer "event_master_id", null: false
    t.integer "exhibitor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_master_id"], name: "index_exhibit_permissions_on_event_master_id"
    t.index ["exhibitor_id"], name: "index_exhibit_permissions_on_exhibitor_id"
  end

  create_table "exhibit_submissions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "movie_url"
    t.integer "status"
    t.string "update_user"
    t.text "update_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.integer "exhibit_informations_id"
    t.index ["exhibit_informations_id"], name: "index_exhibit_submissions_on_exhibit_informations_id"
  end

  create_table "exhibitors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_exhibitors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_exhibitors_on_reset_password_token", unique: true
  end

  create_table "place_block_masters", force: :cascade do |t|
    t.string "block_name"
    t.integer "max_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_master_id"
    t.index ["event_master_id"], name: "index_place_block_masters_on_event_master_id"
  end

  add_foreign_key "exhibit_informations", "exhibitors"
  add_foreign_key "exhibit_permissions", "event_masters"
  add_foreign_key "exhibit_permissions", "exhibitors"
  add_foreign_key "exhibit_submissions", "exhibit_informations", column: "exhibit_informations_id"
  add_foreign_key "place_block_masters", "event_masters"
end
