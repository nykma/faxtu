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

ActiveRecord::Schema.define(version: 20170103052411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logins", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_type",          limit: 10
    t.citext   "login_token",                   default: "", null: false
    t.string   "login_secret",                  default: "", null: false
    t.integer  "sign_in_count",                 default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "auth_token",         limit: 16
    t.index ["login_token"], name: "index_logins_on_login_token", unique: true, using: :btree
    t.index ["user_id", "user_type"], name: "index_logins_on_user_id_and_user_type", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "gender",     limit: 2
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
