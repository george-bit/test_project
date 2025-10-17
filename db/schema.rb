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

ActiveRecord::Schema[8.0].define(version: 2025_10_17_115444) do
  create_table "answers", force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "rating"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "survey_response_id", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["survey_response_id"], name: "index_answers_on_survey_response_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "survey_id", null: false
    t.text "text"
    t.boolean "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "text_answer_optional"
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "survey_responses", force: :cascade do |t|
    t.integer "survey_id", null: false
    t.text "feedback"
    t.string "responder_email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_responses_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "survey_responses"
  add_foreign_key "questions", "surveys"
  add_foreign_key "survey_responses", "surveys"
end
