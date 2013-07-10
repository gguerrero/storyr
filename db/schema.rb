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

ActiveRecord::Schema.define(version: 20130710160243) do

  create_table "rates", force: true do |t|
    t.integer  "value"
    t.text     "comment"
    t.integer  "story_id"
    t.integer  "user_id"
    t.date     "rated_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["story_id"], name: "index_rates_on_story_id", using: :btree
  add_index "rates", ["user_id"], name: "index_rates_on_user_id", using: :btree

  create_table "stories", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.date     "published_on"
    t.string   "tags",         array: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stories", ["user_id"], name: "index_stories_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "fullname"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
