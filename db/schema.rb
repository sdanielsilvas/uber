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

ActiveRecord::Schema.define(version: 20170707161459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "capabilities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "capabilities_products", force: :cascade do |t|
    t.integer "capability_id"
    t.integer "product_id"
    t.index ["capability_id"], name: "index_capabilities_products_on_capability_id", using: :btree
    t.index ["product_id"], name: "index_capabilities_products_on_product_id", using: :btree
  end

  create_table "credentials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "password"
    t.string   "key"
    t.string   "iv"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oportunities", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "identification"
    t.string   "oportunity_source"
    t.string   "assigned_partner"
    t.string   "status"
    t.string   "company_name"
    t.string   "contact_email"
    t.string   "business_phone"
    t.string   "auction_id"
    t.datetime "finalization_date"
    t.string   "current_provider"
    t.integer  "user_id"
    t.integer  "template_id"
  end

  create_table "oportunity_items", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "oportunity_id"
    t.string   "oportunity_identification"
    t.string   "product"
    t.string   "sku"
    t.string   "quantity"
    t.string   "unit_price"
  end

  create_table "oportunity_providers", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "provider_nit"
    t.string   "oportunity_identification"
    t.string   "email"
    t.string   "position"
    t.string   "vendor_name"
    t.string   "points"
    t.string   "price"
    t.string   "training_hours"
    t.string   "support_hours"
    t.string   "local_support"
    t.string   "support_availability"
    t.string   "migration_hours"
    t.string   "status"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "providers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nit"
    t.string   "name"
    t.string   "email"
  end

  create_table "templates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json     "criteria"
    t.integer  "user_id"
    t.string   "company"
    t.string   "name"
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
