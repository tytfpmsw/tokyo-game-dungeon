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

ActiveRecord::Schema[7.1].define(version: 2024_01_14_022928) do
  create_table "exhibit_informations", force: :cascade do |t|
    t.integer "exhibitor_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.text "movie_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibitor_id"], name: "index_exhibit_informations_on_exhibitor_id"
  end

  create_table "exhibit_submissions", force: :cascade do |t|
    t.integer "exhibitor_id", null: false
    t.string "exhibit_title"
    t.text "exhibit_description"
    t.text "exhibit_movie_link"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exhibitor_id"], name: "index_exhibit_submissions_on_exhibitor_id"
  end

  create_table "exhibitors", force: :cascade do |t|
    t.string "name", null: false
    t.string "circle_name", null: false
    t.integer "place_block_master_id"
    t.integer "place_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_block_master_id"], name: "index_exhibitors_on_place_block_master_id"
  end

  create_table "place_block_masters", force: :cascade do |t|
    t.string "block_name", null: false
    t.integer "max_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "exhibit_informations", "exhibitors"
  add_foreign_key "exhibit_submissions", "exhibitors"
  add_foreign_key "exhibitors", "place_block_masters"
end
