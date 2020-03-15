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

ActiveRecord::Schema.define(version: 2020_03_13_083155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone_number"
    t.string "location"
    t.string "address"
    t.integer "number_of_employees"
    t.datetime "date_of_incorporation"
    t.integer "paid_up_capital"
    t.text "logo"
    t.text "header_image"
    t.text "image"
    t.string "email_for_inquiry"
    t.integer "member_status"
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "desired_industries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "industry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "desired_job_categories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "job_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "educations", force: :cascade do |t|
    t.string "school_name"
    t.string "major"
    t.datetime "period_start"
    t.datetime "period_end"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_educations_on_user_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_languages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.integer "salary", null: false
    t.string "number_of_recruits", null: false
    t.string "position", null: false
    t.text "description", null: false
    t.string "location", null: false
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_posts_on_company_id"
  end

  create_table "qualifications", force: :cascade do |t|
    t.string "name"
    t.datetime "date_of_acquisition"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_qualifications_on_user_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.text "image"
    t.datetime "date_of_birth"
    t.string "gender"
    t.string "address"
    t.string "phone_number"
    t.string "race"
    t.string "religion"
    t.integer "expected_salary"
    t.string "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_experiences", force: :cascade do |t|
    t.string "company"
    t.string "position"
    t.datetime "period_start"
    t.datetime "period_end"
    t.boolean "currently_employed"
    t.text "description"
    t.integer "salary"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_work_experiences_on_user_id"
  end

  add_foreign_key "educations", "users"
  add_foreign_key "languages", "users"
  add_foreign_key "posts", "companies"
  add_foreign_key "qualifications", "users"
  add_foreign_key "user_skills", "users"
  add_foreign_key "work_experiences", "users"
end
