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

ActiveRecord::Schema.define(version: 20160930174332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postalcode"
    t.string   "country"
    t.datetime "datetime"
    t.integer  "event_type"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "event_id", null: false
  end

  add_index "events_users", ["event_id", "user_id"], name: "index_events_users_on_event_id_and_user_id", using: :btree
  add_index "events_users", ["user_id", "event_id"], name: "index_events_users_on_user_id_and_event_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "gender"
    t.integer  "age"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "posts", "users"
end
