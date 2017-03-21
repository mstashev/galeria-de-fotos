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

ActiveRecord::Schema.define(version: 20170320213502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "galleries", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.integer  "user_id"
    t.string   "main_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "alt_image"
    t.index ["user_id"], name: "index_galleries_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "name"
    t.string   "caption"
    t.string   "image"
    t.integer  "gallery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "photo"
    t.index ["gallery_id"], name: "index_photos_on_gallery_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "avatar"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "profile_pic"
  end

  add_foreign_key "galleries", "users"
  add_foreign_key "photos", "galleries"
end
