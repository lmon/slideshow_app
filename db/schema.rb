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

ActiveRecord::Schema.define(version: 20140411212225) do

  create_table "assets", force: true do |t|
    t.string   "name"
    t.string   "caption"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "assets_galleries", force: true do |t|
    t.integer "gallery_id"
    t.integer "asset_id"
  end

  add_index "assets_galleries", ["gallery_id", "asset_id"], name: "index_assets_galleries_on_gallery_id_and_asset_id"

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "asset_order"
    t.integer  "private",     default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["user_id", "created_at"], name: "index_galleries_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  default: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
