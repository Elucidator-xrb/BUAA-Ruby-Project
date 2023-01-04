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

ActiveRecord::Schema[7.0].define(version: 2023_01_04_101501) do
  create_table "items", force: :cascade do |t|
    t.integer "shoppinglist_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["shoppinglist_id"], name: "index_items_on_shoppinglist_id"
  end

  create_table "manipulators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "mname", default: "", null: false
    t.integer "mtype", default: 1, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_manipulators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_manipulators_on_reset_password_token", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "pname"
    t.text "description"
    t.float "price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoppinglists", force: :cascade do |t|
    t.integer "mtype"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manipulator_id", null: false
    t.index ["manipulator_id"], name: "index_shoppinglists_on_manipulator_id"
  end

  add_foreign_key "items", "products"
  add_foreign_key "items", "shoppinglists"
  add_foreign_key "shoppinglists", "manipulators"
end
