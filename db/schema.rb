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

ActiveRecord::Schema.define(version: 20160831105712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dishes", force: :cascade do |t|
    t.string   "name"
    t.string   "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "dish_id"
    t.integer  "wine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rating"
    t.index ["dish_id"], name: "index_meals_on_dish_id", using: :btree
    t.index ["user_id"], name: "index_meals_on_user_id", using: :btree
    t.index ["wine_id"], name: "index_meals_on_wine_id", using: :btree
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_steps_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "profile_pic"
    t.string   "uniq_facebook"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "wines", force: :cascade do |t|
    t.string   "nom_vin"
    t.string   "type_vin"
    t.integer  "id_type_vin"
    t.string   "wine_color"
    t.string   "nom_region"
    t.string   "nom_pays"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "meals", "dishes"
  add_foreign_key "meals", "users"
  add_foreign_key "meals", "wines"
  add_foreign_key "steps", "users"
end
