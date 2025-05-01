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

ActiveRecord::Schema[7.2].define(version: 2025_05_01_114719) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chronotypes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "default_schedules", force: :cascade do |t|
    t.bigint "chronotype_id", null: false
    t.string "activity_type"
    t.time "start_time"
    t.time "end_time"
    t.integer "day_of_week"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["chronotype_id"], name: "index_default_schedules_on_chronotype_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "question_text"
    t.string "option1"
    t.string "option2"
    t.string "option3"
    t.integer "score1"
    t.integer "score2"
    t.integer "score3"
    t.integer "part"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "default_schedule_id"
    t.string "title"
    t.datetime "start_time", precision: nil
    t.datetime "end_time", precision: nil
    t.boolean "is_default"
    t.boolean "override_default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["default_schedule_id"], name: "index_schedules_on_default_schedule_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.integer "selected_option", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_user_answers_on_question_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_chronotypes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chronotype_id", null: false
    t.bigint "user_answers_session_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chronotype_id"], name: "index_user_chronotypes_on_chronotype_id"
    t.index ["user_answers_session_id"], name: "index_user_chronotypes_on_user_answers_session_id"
    t.index ["user_id"], name: "index_user_chronotypes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "default_schedules", "chronotypes"
  add_foreign_key "schedules", "default_schedules"
  add_foreign_key "schedules", "users"
  add_foreign_key "user_answers", "questions"
  add_foreign_key "user_answers", "users"
  add_foreign_key "user_chronotypes", "chronotypes"
  add_foreign_key "user_chronotypes", "user_answers", column: "user_answers_session_id"
  add_foreign_key "user_chronotypes", "users"
end
