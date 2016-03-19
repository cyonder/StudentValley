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

ActiveRecord::Schema.define(version: 20160304202927) do

  create_table "books", force: :cascade do |t|
    t.integer  "seller_id",          limit: 4
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.string   "category",           limit: 255
    t.string   "price",              limit: 255
    t.datetime "photo_updated_at"
    t.integer  "photo_file_size",    limit: 4
    t.string   "photo_content_type", limit: 255
    t.string   "photo_file_name",    limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "friend_id",  limit: 4
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.text     "message",      limit: 65535
    t.boolean  "read",                       default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "roommates", force: :cascade do |t|
    t.integer  "seller_id",          limit: 4
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.integer  "street_number",      limit: 4
    t.string   "street_name",        limit: 255
    t.string   "postal_code",        limit: 255
    t.string   "city",               limit: 255
    t.string   "province",           limit: 255
    t.string   "price",              limit: 255
    t.string   "available_date",     limit: 255
    t.boolean  "private_room",                     default: false
    t.boolean  "private_bathroom",                 default: false
    t.string   "laundry_room",       limit: 255
    t.boolean  "pet_friendly",                     default: false
    t.string   "parking_spot",       limit: 255
    t.datetime "photo_updated_at"
    t.integer  "photo_file_size",    limit: 4
    t.string   "photo_content_type", limit: 255
    t.string   "photo_file_name",    limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "email",                  limit: 255
    t.string   "password",               limit: 255
    t.string   "salt",                   limit: 255
    t.string   "authorization_token",    limit: 255
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "username",               limit: 255
    t.string   "school",                 limit: 255
    t.string   "program",                limit: 255
    t.string   "information",            limit: 255
    t.string   "website",                limit: 255
    t.datetime "photo_updated_at"
    t.integer  "photo_file_size",        limit: 4
    t.string   "photo_content_type",     limit: 255
    t.string   "photo_file_name",        limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "users", ["authorization_token"], name: "index_users_on_authorization_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
