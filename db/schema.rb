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

ActiveRecord::Schema.define(version: 2022_08_28_213041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_factors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "value", precision: 8, scale: 3
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_activity_factors_on_created_by_id"
  end

  create_table "billing_items", force: :cascade do |t|
    t.string "description"
    t.integer "item_type", default: 0
    t.integer "quantity", default: 1
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.decimal "total", precision: 8, scale: 2, default: "0.0"
    t.bigint "billing_id", null: false
    t.string "itemable_type"
    t.bigint "itemable_id"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["billing_id"], name: "index_billing_items_on_billing_id"
    t.index ["itemable_type", "itemable_id"], name: "index_billing_items_on_itemable"
  end

  create_table "billings", force: :cascade do |t|
    t.decimal "sub_total", precision: 8, scale: 2, default: "0.0"
    t.decimal "total", precision: 8, scale: 2, default: "0.0"
    t.string "description"
    t.string "code"
    t.integer "billing_type", default: 0
    t.bigint "dietitian_id"
    t.bigint "patient_id", null: false
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_billings_on_created_by_id"
    t.index ["dietitian_id"], name: "index_billings_on_dietitian_id"
    t.index ["patient_id"], name: "index_billings_on_patient_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "discount_type", default: 0
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.integer "status", default: 0
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_discounts_on_created_by_id"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_genders_on_created_by_id"
  end

  create_table "indicator_types", force: :cascade do |t|
    t.text "name"
    t.string "description"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_indicator_types_on_created_by_id"
  end

  create_table "indicators", force: :cascade do |t|
    t.decimal "value_min", precision: 8, scale: 2
    t.decimal "value_max", precision: 8, scale: 2
    t.string "description"
    t.integer "position"
    t.bigint "gender_id", null: false
    t.bigint "indicator_type_id", null: false
    t.bigint "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_indicators_on_created_by_id"
    t.index ["gender_id"], name: "index_indicators_on_gender_id"
    t.index ["indicator_type_id"], name: "index_indicators_on_indicator_type_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "weeks"
    t.decimal "price", precision: 8, scale: 2
    t.integer "status", default: 0
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_packages_on_created_by_id"
  end

  create_table "patient_packages", force: :cascade do |t|
    t.bigint "package_id", null: false
    t.bigint "patient_id", null: false
    t.date "date"
    t.integer "status", default: 0
    t.integer "dietitian_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dietitian_id"], name: "index_patient_packages_on_dietitian_id"
    t.index ["package_id"], name: "index_patient_packages_on_package_id"
    t.index ["patient_id"], name: "index_patient_packages_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "slug"
    t.integer "age"
    t.date "date_of_birth"
    t.integer "gender_id", null: false
    t.bigint "dietitian_id", null: false
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dietitian_id"], name: "index_patients_on_dietitian_id"
  end

  create_table "payment_billing_items", force: :cascade do |t|
    t.bigint "payment_id", null: false
    t.bigint "billing_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["billing_item_id"], name: "index_payment_billing_items_on_billing_item_id"
    t.index ["payment_id"], name: "index_payment_billing_items_on_payment_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "status"
    t.string "code"
    t.bigint "dietitian_id"
    t.bigint "billing_id", null: false
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["billing_id"], name: "index_payments_on_billing_id"
    t.index ["created_by_id"], name: "index_payments_on_created_by_id"
    t.index ["dietitian_id"], name: "index_payments_on_dietitian_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "code"
    t.decimal "price", precision: 8, scale: 2, default: "0.0"
    t.decimal "new_price", precision: 8, scale: 2, default: "0.0"
    t.integer "status", default: 0
    t.bigint "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_products_on_created_by_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_roles_on_created_by_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.decimal "weight", precision: 8, scale: 2
    t.decimal "height", precision: 8, scale: 2
    t.decimal "waist", precision: 8, scale: 2
    t.decimal "hip", precision: 8, scale: 2
    t.decimal "high_abdomen", precision: 8, scale: 2
    t.decimal "low_abdomen", precision: 8, scale: 2
    t.decimal "imc", precision: 8, scale: 2
    t.decimal "ideal_weight", precision: 8, scale: 2
    t.decimal "body_grease", precision: 8, scale: 2
    t.decimal "visceral_grease", precision: 8, scale: 2
    t.decimal "muscle_mass", precision: 8, scale: 2
    t.decimal "bone_mass", precision: 8, scale: 2
    t.integer "water_percentage"
    t.integer "bmr"
    t.integer "metabolic_age"
    t.integer "physical_complexion"
    t.date "date"
    t.bigint "patient_id", null: false
    t.bigint "patient_package_id", null: false
    t.integer "dietitian_id"
    t.integer "activity_factor_id"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_sessions_on_created_by_id"
    t.index ["dietitian_id"], name: "index_sessions_on_dietitian_id"
    t.index ["patient_id"], name: "index_sessions_on_patient_id"
    t.index ["patient_package_id"], name: "index_sessions_on_patient_package_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_user_roles_on_created_by_id"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "patient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["patient_id"], name: "index_users_on_patient_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activity_factors", "users", column: "created_by_id"
  add_foreign_key "billing_items", "billings"
  add_foreign_key "billings", "patients"
  add_foreign_key "billings", "users", column: "created_by_id"
  add_foreign_key "billings", "users", column: "dietitian_id"
  add_foreign_key "discounts", "users", column: "created_by_id"
  add_foreign_key "genders", "users", column: "created_by_id"
  add_foreign_key "indicator_types", "users", column: "created_by_id"
  add_foreign_key "indicators", "genders"
  add_foreign_key "indicators", "indicator_types"
  add_foreign_key "indicators", "users", column: "created_by_id"
  add_foreign_key "packages", "users", column: "created_by_id"
  add_foreign_key "patient_packages", "packages"
  add_foreign_key "patient_packages", "patients"
  add_foreign_key "patients", "users", column: "dietitian_id"
  add_foreign_key "payment_billing_items", "billing_items"
  add_foreign_key "payment_billing_items", "payments"
  add_foreign_key "payments", "billings"
  add_foreign_key "payments", "users", column: "created_by_id"
  add_foreign_key "payments", "users", column: "dietitian_id"
  add_foreign_key "products", "users", column: "created_by_id"
  add_foreign_key "roles", "users", column: "created_by_id"
  add_foreign_key "sessions", "patient_packages"
  add_foreign_key "sessions", "patients"
  add_foreign_key "sessions", "users", column: "created_by_id"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "user_roles", "users", column: "created_by_id"
end
