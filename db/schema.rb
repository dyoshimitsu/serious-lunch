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

ActiveRecord::Schema.define(version: 2018_04_23_095321) do

  create_table "account_activations", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "activation_digest", null: false
    t.boolean "activated", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_activations_on_account_id", unique: true
    t.index ["activated"], name: "index_account_activations_on_activated"
  end

  create_table "account_cookies", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "remember_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_cookies_on_account_id", unique: true
  end

  create_table "account_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "follower_account_id"
    t.bigint "followed_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "account_resets", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "reset_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_resets_on_account_id", unique: true
  end

  create_table "accounts", primary_key: "account_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "account_name", limit: 50, null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_name"], name: "index_accounts_on_account_name", unique: true
    t.index ["email_address"], name: "index_accounts_on_email_address", unique: true
  end

  create_table "lunches", primary_key: "lunch_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.date "lunch_date", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "created_at"], name: "index_lunches_on_account_id_and_created_at"
    t.index ["account_id", "lunch_date"], name: "index_lunches_on_account_id_and_lunch_date"
  end

  add_foreign_key "account_activations", "accounts", primary_key: "account_id"
  add_foreign_key "account_cookies", "accounts", primary_key: "account_id"
  add_foreign_key "account_resets", "accounts", primary_key: "account_id"
  add_foreign_key "lunches", "accounts", primary_key: "account_id"
end
