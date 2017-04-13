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

ActiveRecord::Schema.define(version: 20170401042545) do

  create_table "pilot_planes", force: :cascade do |t|
    t.integer  "pilot_id"
    t.integer  "plane_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pilots", force: :cascade do |t|
    t.string   "username"
    t.string   "branch"
    t.string   "rank"
    t.string   "victories"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "plane_weapons", force: :cascade do |t|
    t.integer  "plane_id"
    t.integer  "weapon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "planes", force: :cascade do |t|
    t.string   "name"
    t.string   "manufacturer"
    t.string   "top_speed"
    t.string   "ceiling"
    t.string   "classification"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.string   "name"
    t.string   "classification"
    t.string   "caliber"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
