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

ActiveRecord::Schema[7.0].define(version: 2022_09_26_204232) do
  create_table "addresses", force: :cascade do |t|
    t.string "house"
    t.string "street"
    t.string "postcode"
    t.string "town"
    t.string "country"
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "category_id"
    t.string "name"
    t.string "url"
    t.text "description"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_categories_on_product_id"
    t.index ["url"], name: "index_categories_on_url", unique: true
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer "image_id"
    t.string "name"
    t.string "path"
    t.string "alt_tag"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_images_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "address_id"
    t.json "products"
    t.decimal "cost", precision: 10, scale: 4
    t.string "paypal_status"
    t.string "paypal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "paypal_tokens", force: :cascade do |t|
    t.string "access_token"
    t.string "app_id"
    t.datetime "expires_in"
    t.string "nonce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
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

  add_foreign_key "addresses", "customers"
  add_foreign_key "categories", "products"
  add_foreign_key "images", "products"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "customers"
  add_foreign_key "products", "categories"
end
