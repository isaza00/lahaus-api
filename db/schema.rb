# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_15_003144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "photos", force: :cascade do |t|
    t.string "url"
    t.bigint "property_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "accepted_foc"
    t.boolean "accepted_lum"
    t.index ["property_id"], name: "index_photos_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "project"
    t.string "built_type"
    t.string "price"
    t.string "address"
    t.string "apt"
    t.string "hood"
    t.string "city"
    t.string "private_area"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "admon"
    t.string "build_area"
    t.string "social_class"
    t.string "state"
    t.boolean "elevator"
    t.string "common_areas"
    t.string "property_tax"
    t.string "rooms"
    t.string "bathrooms"
    t.string "half_bathrooms"
    t.string "parking_lot"
    t.boolean "utility_room"
    t.boolean "empty_property"
    t.boolean "inhabitants"
    t.string "rent"
    t.string "mortgage"
    t.index ["built_type"], name: "index_properties_on_built_type"
    t.index ["city"], name: "index_properties_on_city"
    t.index ["hood"], name: "index_properties_on_hood"
    t.index ["price"], name: "index_properties_on_price"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "isadmin", default: false
    t.string "full_name"
    t.string "cellphone"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "photos", "properties"
  add_foreign_key "properties", "users"
end
