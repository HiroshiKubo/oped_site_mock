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

ActiveRecord::Schema.define(version: 20160430074852) do

  create_table "anime_data", force: :cascade do |t|
    t.string   "japanese"
    t.string   "english"
    t.string   "chinese"
    t.string   "year"
    t.integer  "month"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "anime_id"
    t.string   "title"
    t.integer  "video_id"
    t.text     "content"
    t.string   "oped"
    t.integer  "number"
    t.string   "advertisement"
    t.string   "initials"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "release"
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "anime_id"
    t.string   "image"
    t.string   "video_url"
    t.string   "frame"
    t.boolean  "release"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

end
