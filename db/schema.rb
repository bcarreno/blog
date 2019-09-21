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

ActiveRecord::Schema.define(version: 2017_01_18_032657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "keywords"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "markdown", default: false, null: false
    t.string "cached_slug"
    t.boolean "is_published", default: false, null: false
    t.boolean "comments_allowed", default: true, null: false
    t.index ["cached_slug"], name: "index_articles_on_cached_slug"
  end

  create_table "articles_categories", id: false, force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "category_id", null: false
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "body"
    t.integer "article_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "email"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "admin", default: false, null: false
  end

  create_table "videos", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.string "youtube_id", null: false
    t.integer "duration"
    t.boolean "is_hd", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
