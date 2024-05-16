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

ActiveRecord::Schema[7.1].define(version: 2024_05_15_105145) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "image"
    t.string "position"
    t.bigint "product_id", null: false
    t.bigint "entity_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_assets_on_company_id"
    t.index ["entity_id"], name: "index_assets_on_entity_id"
    t.index ["product_id"], name: "index_assets_on_product_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "city"
    t.string "street"
    t.string "build"
    t.string "flat"
    t.string "description"
    t.boolean "active", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "fcm_token"
    t.string "platform"
    t.boolean "active", default: false
    t.string "app_version"
    t.string "identifier"
    t.datetime "confirmed_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "entities", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.string "state"
    t.boolean "ready"
    t.integer "pattern_id"
    t.bigint "mediaset_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mediaset_id"], name: "index_entities_on_mediaset_id"
  end

  create_table "mediasets", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "state"
    t.boolean "ready", default: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_mediasets_on_product_id"
  end

  create_table "patterns", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "image"
    t.integer "road_height"
    t.bigint "product_id", null: false
    t.bigint "entity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_patterns_on_entity_id"
    t.index ["product_id"], name: "index_patterns_on_product_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "entity_id", null: false
    t.bigint "mediaset_id", null: false
    t.string "photo"
    t.integer "width"
    t.integer "height"
    t.integer "file_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_photos_on_entity_id"
    t.index ["mediaset_id"], name: "index_photos_on_mediaset_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.boolean "enabled", default: true
    t.integer "product_setting_id"
    t.integer "pattern_id"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "ip"
    t.string "access_token"
    t.datetime "access_token_expires_at"
    t.string "refresh_token"
    t.datetime "refresh_token_expires_at"
    t.bigint "device_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_sessions_on_device_id"
  end

  create_table "sms_confirmations", force: :cascade do |t|
    t.string "state"
    t.datetime "confirmed_at"
    t.integer "count_failure_input"
    t.integer "code"
    t.bigint "device_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_sms_confirmations_on_device_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "middlename"
    t.string "email"
    t.boolean "agreement", default: false
    t.string "phone"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assets", "companies"
  add_foreign_key "assets", "entities"
  add_foreign_key "assets", "products"
  add_foreign_key "companies", "users"
  add_foreign_key "devices", "users"
  add_foreign_key "entities", "mediasets"
  add_foreign_key "mediasets", "products"
  add_foreign_key "patterns", "entities"
  add_foreign_key "patterns", "products"
  add_foreign_key "photos", "entities"
  add_foreign_key "photos", "mediasets"
  add_foreign_key "products", "companies"
  add_foreign_key "sessions", "devices"
  add_foreign_key "sms_confirmations", "devices"
end
