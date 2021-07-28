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

ActiveRecord::Schema.define(version: 2021_07_28_015632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer "first_level_cat_id", null: false
    t.integer "parent_cat_id"
    t.string "name", null: false
    t.string "label", null: false
    t.boolean "leaf", null: false
    t.string "cat_property_models", default: [], array: true
    t.json "rules", default: {}
    t.integer "lsc_set_id", default: 0
    t.boolean "variation_cat", default: false
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_cat_id"], name: "index_categories_on_parent_cat_id"
  end

end
