# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140113172406) do

  create_table "event_entries", force: true do |t|
    t.text     "event_description"
    t.integer  "event_timestamp"
    t.integer  "event_rating"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_entries", ["user_id"], name: "index_event_entries_on_user_id", using: :btree

  create_table "food_entries", force: true do |t|
    t.integer  "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "food_entries", ["user_id"], name: "index_food_entries_on_user_id", using: :btree

  create_table "food_entries_foods", id: false, force: true do |t|
    t.integer "food_id"
    t.integer "food_entry_id"
  end

  add_index "food_entries_foods", ["food_entry_id"], name: "index_food_entries_foods_on_food_entry_id", using: :btree
  add_index "food_entries_foods", ["food_id"], name: "index_food_entries_foods_on_food_id", using: :btree

  create_table "foods", force: true do |t|
    t.string   "food_name"
    t.text     "cooked_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

end
