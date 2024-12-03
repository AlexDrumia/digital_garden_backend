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

ActiveRecord::Schema[7.2].define(version: 2024_11_24_094035) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "age_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "airtable_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "airtable_id"
    t.index ["airtable_id"], name: "index_categories_on_airtable_id", unique: true
  end

  create_table "categories_events", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "event_id"], name: "index_categories_events_on_category_id_and_event_id", unique: true
    t.index ["category_id"], name: "index_categories_events_on_category_id"
    t.index ["event_id", "category_id"], name: "index_categories_events_on_event_id_and_category_id", unique: true
    t.index ["event_id"], name: "index_categories_events_on_event_id"
  end

  create_table "event_age_groups", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "age_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["age_group_id"], name: "index_event_age_groups_on_age_group_id"
    t.index ["event_id"], name: "index_event_age_groups_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.string "location"
    t.text "description"
    t.datetime "start_datetime", null: false
    t.datetime "end_datetime"
    t.decimal "price", precision: 10, scale: 2
    t.bigint "organizer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_url"
    t.boolean "kid_friendly", default: false
    t.string "airtable_id"
    t.string "image_url"
    t.index ["airtable_id"], name: "index_events_on_airtable_id", unique: true
    t.index ["name"], name: "index_events_on_name"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
    t.index ["price"], name: "index_events_on_price"
    t.index ["start_datetime"], name: "index_events_on_start_datetime"
  end

  create_table "organizers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "airtable_id"
    t.index ["airtable_id"], name: "index_organizers_on_airtable_id", unique: true
  end

  add_foreign_key "categories_events", "categories"
  add_foreign_key "categories_events", "events"
  add_foreign_key "event_age_groups", "age_groups"
  add_foreign_key "event_age_groups", "events"
  add_foreign_key "events", "organizers"
end
