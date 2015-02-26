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

ActiveRecord::Schema.define(version: 20150222162346) do

  create_table "comments", force: true do |t|
    t.string  "comment"
    t.integer "packets_id"
    t.integer "users_id"
  end

  create_table "contacts", id: false, force: true do |t|
    t.integer "persons_id"
    t.integer "contacts_id"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packets", force: true do |t|
    t.integer  "projects_id"
    t.string   "packet_name"
    t.date     "start_date"
    t.date     "deadline"
    t.integer  "status"
    t.string   "description"
    t.float    "expenses"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "packets", ["projects_id"], name: "index_packets_on_projects_id"

  create_table "projects", force: true do |t|
    t.string   "project_name"
    t.date     "start_date"
    t.date     "deadline"
    t.string   "description"
    t.decimal  "budget"
    t.float    "progress"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_mailers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_packets", id: false, force: true do |t|
    t.integer "users_id"
    t.integer "packets_id"
    t.integer "users_roles"
  end

  create_table "user_projects", id: false, force: true do |t|
    t.integer "users_id"
    t.integer "projects_id"
    t.integer "users_roles"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true

end
