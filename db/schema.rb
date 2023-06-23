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

ActiveRecord::Schema[7.0].define(version: 2023_06_22_015837) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contract_resources", force: :cascade do |t|
    t.bigint "resource_id", null: false
    t.bigint "contract_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_contract_resources_on_contract_id"
    t.index ["resource_id"], name: "index_contract_resources_on_resource_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.text "description"
    t.string "from_planet"
    t.string "to_planet"
    t.float "value"
    t.string "status", default: "OPEN"
    t.bigint "ship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ship_id"], name: "index_contracts_on_ship_id"
  end

  create_table "fuel_refills", force: :cascade do |t|
    t.bigint "pilot_id", null: false
    t.integer "fuel"
    t.integer "cost"
    t.boolean "discounted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pilot_id"], name: "index_fuel_refills_on_pilot_id"
  end

  create_table "pilots", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.float "credits"
    t.string "certification"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ships", force: :cascade do |t|
    t.float "fuel_capacity"
    t.float "fuel_level"
    t.float "weight_capacity"
    t.bigint "pilot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pilot_id"], name: "index_ships_on_pilot_id"
  end

  create_table "travels", force: :cascade do |t|
    t.string "from_planet"
    t.string "to_planet"
    t.integer "fuel_consumption"
    t.bigint "ship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ship_id"], name: "index_travels_on_ship_id"
  end

  add_foreign_key "contract_resources", "contracts"
  add_foreign_key "contract_resources", "resources"
  add_foreign_key "contracts", "ships"
  add_foreign_key "fuel_refills", "pilots"
  add_foreign_key "ships", "pilots"
  add_foreign_key "travels", "ships"
end
