# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160323015259) do

  create_table "bleeds", force: :cascade do |t|
    t.boolean  "front"
    t.boolean  "back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "box_counts", force: :cascade do |t|
    t.integer  "box_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_cards", force: :cascade do |t|
    t.integer  "price"
    t.integer  "cost"
    t.integer  "print_method_id"
    t.integer  "ink_color_id"
    t.integer  "bleed_id"
    t.integer  "raised_ink_id"
    t.integer  "dimension_id"
    t.integer  "paper_type_id"
    t.integer  "coating_id"
    t.integer  "quantity_id"
    t.integer  "box_count_id"
    t.integer  "metal_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "business_cards", ["bleed_id"], name: "index_business_cards_on_bleed_id"
  add_index "business_cards", ["box_count_id"], name: "index_business_cards_on_box_count_id"
  add_index "business_cards", ["coating_id"], name: "index_business_cards_on_coating_id"
  add_index "business_cards", ["dimension_id"], name: "index_business_cards_on_dimension_id"
  add_index "business_cards", ["ink_color_id"], name: "index_business_cards_on_ink_color_id"
  add_index "business_cards", ["metal_id"], name: "index_business_cards_on_metal_id"
  add_index "business_cards", ["paper_type_id"], name: "index_business_cards_on_paper_type_id"
  add_index "business_cards", ["print_method_id"], name: "index_business_cards_on_print_method_id"
  add_index "business_cards", ["quantity_id"], name: "index_business_cards_on_quantity_id"
  add_index "business_cards", ["raised_ink_id"], name: "index_business_cards_on_raised_ink_id"

  create_table "coatings", force: :cascade do |t|
    t.string   "front"
    t.string   "back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dimensions", force: :cascade do |t|
    t.float    "width"
    t.float    "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ink_colors", force: :cascade do |t|
    t.integer  "front"
    t.integer  "back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metals", force: :cascade do |t|
    t.string   "front"
    t.string   "back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paper_types", force: :cascade do |t|
    t.string   "brand"
    t.string   "name"
    t.string   "color"
    t.integer  "thickness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "print_methods", force: :cascade do |t|
    t.string   "print_method"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "quantities", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "raised_inks", force: :cascade do |t|
    t.integer  "front"
    t.integer  "back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
