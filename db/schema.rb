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

ActiveRecord::Schema[8.0].define(version: 2025_05_23_031441) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "fake_name"
    t.integer "state"
    t.string "address"
    t.integer "activity"
    t.integer "size"
    t.integer "man_workers"
    t.integer "woman_workers"
    t.integer "start_year"
    t.string "contact_name"
    t.string "contact_position"
    t.string "contact_tel"
    t.string "contact_email"
    t.boolean "is_confirmed"
    t.boolean "is_main_company"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "registration_number"
    t.index ["confirmation_token"], name: "index_companies_on_confirmation_token", unique: true
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "company_main_companies", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.integer "main_company", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_main_companies_on_company_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ovalue"
    t.integer "otype"
    t.text "prefix"
    t.text "sufix"
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "poll_areas", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "area_id", null: false
    t.bigint "provision_id", null: false
    t.text "last_disclaimer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_poll_areas_on_area_id"
    t.index ["provision_id"], name: "index_poll_areas_on_provision_id"
  end

  create_table "poll_questions", force: :cascade do |t|
    t.bigint "poll_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "semaphore_id", default: 1, null: false
    t.integer "condition_question"
    t.integer "condition_operator"
    t.integer "condition_value"
    t.boolean "section_yellow"
    t.boolean "section_red"
    t.integer "question_weight"
    t.index ["poll_id"], name: "index_poll_questions_on_poll_id"
    t.index ["question_id"], name: "index_poll_questions_on_question_id"
    t.index ["semaphore_id"], name: "index_poll_questions_on_semaphore_id"
  end

  create_table "poll_sections", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "poll_id", null: false
    t.bigint "semaphore_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "disabled"
    t.index ["poll_id"], name: "index_poll_sections_on_poll_id"
    t.index ["section_id"], name: "index_poll_sections_on_section_id"
    t.index ["semaphore_id"], name: "index_poll_sections_on_semaphore_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "area_id", null: false
    t.bigint "provision_id", null: false
    t.text "last_disclaimer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_polls_on_area_id"
    t.index ["provision_id"], name: "index_polls_on_provision_id"
  end

  create_table "provisions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "qtype"
    t.string "title"
    t.text "description"
    t.integer "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "section_id", null: false
    t.bigint "semaphore_id", null: false
    t.index ["section_id"], name: "index_questions_on_section_id"
    t.index ["semaphore_id"], name: "index_questions_on_semaphore_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight"
  end

  create_table "semaphores", force: :cascade do |t|
    t.string "formula"
    t.text "green_text"
    t.integer "green_value"
    t.text "yellow_text"
    t.text "red_text"
    t.integer "red_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "company_main_companies", "companies"
  add_foreign_key "options", "questions"
  add_foreign_key "poll_areas", "areas"
  add_foreign_key "poll_areas", "provisions"
  add_foreign_key "poll_questions", "polls"
  add_foreign_key "poll_questions", "questions"
  add_foreign_key "poll_questions", "semaphores"
  add_foreign_key "poll_sections", "polls"
  add_foreign_key "poll_sections", "sections"
  add_foreign_key "poll_sections", "semaphores"
  add_foreign_key "polls", "areas"
  add_foreign_key "polls", "provisions"
  add_foreign_key "questions", "sections"
  add_foreign_key "questions", "semaphores"
end
