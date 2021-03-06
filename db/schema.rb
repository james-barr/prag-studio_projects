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

ActiveRecord::Schema.define(version: 20170831223657) do

  create_table "characterizations", force: :cascade do |t|
    t.integer "project_id"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_characterizations_on_project_id"
    t.index ["type_id"], name: "index_characterizations_on_type_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_follows_on_project_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "pledges", force: :cascade do |t|
    t.text "comment"
    t.integer "pledge"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.integer "user_id"
    t.index ["project_id"], name: "index_pledges_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "target_pledge_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "pledging_ends_on"
    t.string "website"
    t.string "team_members"
    t.string "image_file_name"
    t.string "slug"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "admin"
  end

end
