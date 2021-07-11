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

ActiveRecord::Schema.define(version: 2021_07_11_221220) do

  create_table "carriers", force: :cascade do |t|
    t.string "name"
    t.string "suffix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checkins", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_date"
    t.index ["user_id"], name: "index_checkins_on_user_id"
  end

# Could not dump table "churches" because of following StandardError
#   Unknown type 'bool' for column 'logo'

  create_table "events", force: :cascade do |t|
    t.text "description"
    t.string "cost"
    t.datetime "estart"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string "item"
    t.string "serial_number"
    t.string "location"
    t.date "warranty_ends"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "body"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offerings", force: :cascade do |t|
    t.string "stripe_id"
    t.string "uid"
    t.string "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "cover"
    t.boolean "acknowledge", default: false
    t.string "target", default: "General Gift"
  end

  create_table "pronouns", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string "who"
    t.text "reason"
    t.boolean "call_back"
    t.boolean "visit"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'bool' for column 'professing_member'

  create_table "volunteers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
