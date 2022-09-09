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

ActiveRecord::Schema[7.0].define(version: 2022_09_07_210218) do
  create_table "categories", force: :cascade do |t|
    t.integer "category_id"
    t.string "name"
    t.string "url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_categories_on_url", unique: true
  end

  create_table "image_collections", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_image_collections_on_product_id"
  end

  create_table "images", force: :cascade do |t|
    t.integer "image_id"
    t.string "name"
    t.string "path"
    t.string "alt_tag"
    t.integer "image_collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_collection_id"], name: "index_images_on_image_collection_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "product_id"
    t.string "sku"
    t.string "name"
    t.string "url"
    t.decimal "price", precision: 10, scale: 4
    t.boolean "enabled"
    t.text "description"
    t.integer "stock_qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sku"], name: "index_products_on_sku", unique: true
    t.index ["url"], name: "index_products_on_url", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.integer "user_id"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "image_collections", "products"
  add_foreign_key "images", "image_collections"
end
