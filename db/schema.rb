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

ActiveRecord::Schema.define(version: 20161208194228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "num_value"
    t.string   "str_value"
    t.boolean  "bool_value"
    t.integer  "question_id"
    t.integer  "survey_id"
    t.integer  "response_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "text"
    t.text     "details"
    t.string   "input_type"
    t.string   "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "survey_id"
    t.integer  "qid"
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "researcher_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
