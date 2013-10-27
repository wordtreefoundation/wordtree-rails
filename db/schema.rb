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

ActiveRecord::Schema.define(version: 20131027170540) do

  create_table "baselines", force: true do |t|
    t.string   "name"
    t.integer  "year_min"
    t.integer  "year_max"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "uuid"
    t.string   "title"
    t.string   "author"
    t.integer  "year"
    t.integer  "shelf_id"
    t.boolean  "processed"
    t.string   "archive_org_id"
    t.string   "google_id"
    t.integer  "wordcount"
    t.string   "md5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comparisons", force: true do |t|
    t.integer  "query_id"
    t.integer  "book_id"
    t.float    "score"
    t.float    "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queries", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "sample_size"
    t.integer  "book_id"
    t.integer  "minus_shelf_id"
    t.integer  "year_min"
    t.integer  "year_max"
    t.integer  "ngrams"
    t.string   "score_method"
    t.integer  "baseline_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shelves", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "provider"
    t.string   "encrypted_password"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
