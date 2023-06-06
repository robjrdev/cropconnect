# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_30_113456) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "rice_id", null: false
    t.decimal "bidding_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rice_id"], name: "index_bids_on_rice_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.string "message"
    t.boolean "is_read", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.decimal "age"
    t.decimal "whiteness"
    t.decimal "dryness"
    t.decimal "pureness"
    t.bigint "rice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rice_id"], name: "index_ratings_on_rice_id"
  end

  create_table "rice", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.decimal "bidding_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "highest_bidder"
    t.datetime "bid_end_time"
    t.index ["user_id"], name: "index_rice_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.string "contact_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bids", "rice"
  add_foreign_key "bids", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "ratings", "rice"
  add_foreign_key "rice", "users"
end
