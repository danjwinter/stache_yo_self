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

ActiveRecord::Schema.define(version: 20160311190615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "face_locations", force: :cascade do |t|
    t.integer  "mustache_request_id"
    t.decimal  "mouth_left_x"
    t.decimal  "mouth_right_x"
    t.decimal  "mouth_left_y"
    t.decimal  "mouth_right_y"
    t.decimal  "nose_y"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "face_locations", ["mustache_request_id"], name: "index_face_locations_on_mustache_request_id", using: :btree

  create_table "mustache_requests", force: :cascade do |t|
    t.string   "uid"
    t.string   "channel"
    t.boolean  "headless"
    t.string   "stached_user_image_file_name"
    t.string   "stached_user_image_content_type"
    t.integer  "stached_user_image_file_size"
    t.datetime "stached_user_image_updated_at"
    t.string   "original_user_image_file_name"
    t.string   "original_user_image_content_type"
    t.integer  "original_user_image_file_size"
    t.datetime "original_user_image_updated_at"
    t.integer  "slack_team_id"
  end

  add_index "mustache_requests", ["slack_team_id"], name: "index_mustache_requests_on_slack_team_id", using: :btree

  create_table "slack_teams", force: :cascade do |t|
    t.string "team_id"
    t.string "team_name"
    t.string "access_token"
    t.string "bot_user_id"
    t.string "bot_access_token"
  end

  create_table "user_infos", force: :cascade do |t|
    t.integer "mustache_request_id"
    t.string  "image_url"
    t.string  "user_full_name"
  end

  add_index "user_infos", ["mustache_request_id"], name: "index_user_infos_on_mustache_request_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer "slack_team_id"
    t.string  "uid"
    t.string  "screen_name"
    t.string  "first_name"
  end

  add_index "users", ["slack_team_id"], name: "index_users_on_slack_team_id", using: :btree

  add_foreign_key "face_locations", "mustache_requests"
  add_foreign_key "mustache_requests", "slack_teams"
  add_foreign_key "user_infos", "mustache_requests"
  add_foreign_key "users", "slack_teams"
end
