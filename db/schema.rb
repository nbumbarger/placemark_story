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

ActiveRecord::Schema.define(version: 20150508234521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "placemarks", force: :cascade do |t|
    t.integer  "story_id"
    t.string   "name",        null: false
    t.text     "description"
    t.text     "link"
    t.decimal  "lat",         null: false
    t.decimal  "lng",         null: false
    t.binary   "image_data"
    t.string   "image_alt"
    t.integer  "story_order"
    t.datetime "deleted_at"
  end

  create_table "stories", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "deleted_at"
  end

end
