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

ActiveRecord::Schema.define(version: 20160104104817) do

  create_table "answers", force: true do |t|
    t.boolean  "answer"
    t.integer  "happinesstracker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["happinesstracker_id"], name: "index_answers_on_happinesstracker_id"

  create_table "c1answers", force: true do |t|
    t.boolean  "answer"
    t.integer  "questionnbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "c2answers", force: true do |t|
    t.boolean  "answer"
    t.integer  "closedquestion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "c2answers", ["closedquestion_id"], name: "index_c2answers_on_closedquestion_id"

  create_table "canswers", force: true do |t|
    t.boolean  "answer"
    t.integer  "closed_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "canswers", ["closed_question_id"], name: "index_canswers_on_closed_question_id"

  create_table "closed_answers", force: true do |t|
    t.boolean  "Answer"
    t.integer  "closed_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "closed_answers", ["closed_question_id"], name: "index_closed_answers_on_closed_question_id"

  create_table "closed_questions", force: true do |t|
    t.string   "closedquestion"
    t.boolean  "is_visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cquestions", force: true do |t|
    t.string   "question"
    t.boolean  "is_visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "happinesstrackers", force: true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "happy1answers", force: true do |t|
    t.boolean  "hanswer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "happyanswers", force: true do |t|
    t.boolean  "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oanswers", force: true do |t|
    t.text     "answer"
    t.integer  "questionid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_questions", force: true do |t|
    t.string   "openquestion"
    t.string   "createdby"
    t.date     "createdfordate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stressed1answers", force: true do |t|
    t.boolean  "sanswer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stressedanswers", force: true do |t|
    t.boolean  "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
