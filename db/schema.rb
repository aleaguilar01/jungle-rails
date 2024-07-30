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

ActiveRecord::Schema.define(version: 2024_07_25_055510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "Mixtape", id: :text, force: :cascade do |t|
    t.text "title", null: false
    t.text "userId", null: false
    t.datetime "createdAt", precision: 3, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updatedAt", precision: 3, null: false
    t.boolean "isDefault", default: false, null: false
    t.text "description"
    t.text "imageUrl"
  end

# Could not dump table "Tracks" because of following StandardError
#   Unknown type '"TrackType"' for column 'type'

  create_table "User", id: :text, force: :cascade do |t|
    t.text "email", null: false
    t.text "name"
    t.text "password", null: false
    t.text "refreshToken"
    t.index ["email"], name: "User_email_key", unique: true
  end

  create_table "_prisma_migrations", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "checksum", limit: 64, null: false
    t.datetime "finished_at"
    t.string "migration_name", limit: 255, null: false
    t.text "logs"
    t.datetime "rolled_back_at"
    t.datetime "started_at", default: -> { "now()" }, null: false
    t.integer "applied_steps_count", default: 0, null: false
  end

  create_table "appointments", id: :serial, force: :cascade do |t|
    t.string "time", limit: 255, null: false
    t.integer "day_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "available_interviewers", id: :serial, force: :cascade do |t|
    t.integer "day_id"
    t.integer "interviewer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "days", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "interviewers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "avatar", limit: 255, null: false
  end

  create_table "interviews", id: :serial, force: :cascade do |t|
    t.string "student", limit: 255, null: false
    t.integer "interviewer_id"
    t.integer "appointment_id"
    t.index ["appointment_id"], name: "interviews_appointment_id_key", unique: true
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.integer "item_price_cents"
    t.integer "total_price_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_charge_id"
    t.string "email"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.integer "price_cents"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  add_foreign_key "Mixtape", "\"User\"", column: "userId", name: "Mixtape_userId_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "Tracks", "\"Mixtape\"", column: "mixtapeId", name: "Tracks_mixtapeId_fkey", on_update: :cascade, on_delete: :restrict
  add_foreign_key "appointments", "days", name: "appointments_day_id_fkey", on_delete: :cascade
  add_foreign_key "available_interviewers", "days", name: "available_interviewers_day_id_fkey", on_delete: :cascade
  add_foreign_key "available_interviewers", "interviewers", name: "available_interviewers_interviewer_id_fkey", on_delete: :cascade
  add_foreign_key "interviews", "appointments", name: "interviews_appointment_id_fkey", on_delete: :cascade
  add_foreign_key "interviews", "interviewers", name: "interviews_interviewer_id_fkey", on_delete: :cascade
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "products", "categories"
end
