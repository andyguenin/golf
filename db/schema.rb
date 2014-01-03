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

ActiveRecord::Schema.define(:version => 20140103051222) do

  create_table "courses", :force => true do |t|
    t.integer  "tournament_id"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "location"
  end

  create_table "holes", :force => true do |t|
    t.integer  "course_id"
    t.integer  "hole_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "par"
  end

  create_table "nonmember_invitees", :force => true do |t|
    t.integer  "pool_id"
    t.integer  "inviter_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "activation_key"
    t.integer  "user_id"
  end

  create_table "options", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "picks", :force => true do |t|
    t.integer  "pool_membership_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "p1"
    t.integer  "p2"
    t.integer  "p3"
    t.integer  "p4"
    t.integer  "p5"
    t.boolean  "q1"
    t.boolean  "q2"
    t.boolean  "q3"
    t.boolean  "q4"
    t.boolean  "q5"
    t.integer  "tiebreak"
    t.integer  "score"
  end

  create_table "player_premia", :force => true do |t|
    t.integer  "pool_id"
    t.integer  "player_id"
    t.integer  "premium"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ranking"
    t.string   "slug"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "pool_admins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pool_id"
    t.boolean  "creator"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pool_memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pool_id"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "inviter_id"
  end

  create_table "pools", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "tournament_id"
    t.integer  "min_units"
    t.string   "name"
    t.boolean  "published"
    t.boolean  "private"
    t.boolean  "nonadmin_invite"
  end

  create_table "q_answers", :force => true do |t|
    t.integer  "pool_id"
    t.boolean  "answer"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "question"
    t.integer  "number"
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "starttime"
    t.datetime "endtime"
    t.string   "slug"
    t.integer  "round"
    t.integer  "low_score"
    t.boolean  "locked"
  end

  create_table "tplayers", :force => true do |t|
    t.integer  "player_id"
    t.integer  "tournament_id"
    t.integer  "bucket"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "score"
    t.integer  "status"
    t.integer  "deagle"
    t.integer  "eagle"
    t.integer  "birdie"
    t.integer  "par"
    t.integer  "bogey"
    t.integer  "dbogey"
    t.integer  "tbogey"
    t.integer  "round"
    t.integer  "hole"
    t.string   "rank"
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
    t.boolean  "active"
  end

end
