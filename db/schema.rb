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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130421011927) do

  create_table "courses", :force => true do |t|
    t.integer  "tournament_id"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "golfpicks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pick1"
    t.integer  "pick2"
    t.integer  "pick3"
    t.integer  "pick4"
    t.integer  "pick5"
    t.boolean  "q1"
    t.boolean  "q2"
    t.boolean  "q3"
    t.boolean  "q4"
    t.boolean  "q5"
    t.integer  "tiebreak"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "pool_id"
    t.integer  "score"
    t.integer  "bonus"
  end

  create_table "group_admins", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  create_table "holes", :force => true do |t|
    t.integer  "course_id"
    t.integer  "hole_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "par"
  end

  create_table "options", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "player_premia", :force => true do |t|
    t.integer  "pool_id"
    t.integer  "player_id"
    t.integer  "premium"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "player_score_statuses", :force => true do |t|
    t.integer  "player_id"
    t.integer  "tournament_id"
    t.integer  "score"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ranking"
  end

  create_table "pools", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "group_id"
    t.integer  "tournament_id"
    t.integer  "min_units"
  end

  create_table "scores", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "player_id"
    t.integer  "strokes"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "hole_id"
    t.integer  "round"
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "starttime"
    t.datetime "endtime"
    t.string   "slug"
    t.integer  "round"
  end

  create_table "tplayers", :force => true do |t|
    t.integer  "player_id"
    t.integer  "tournament_id"
    t.integer  "bucket"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_group_members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "admin"
    t.integer  "role"
  end

end
