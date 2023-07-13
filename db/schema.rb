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

ActiveRecord::Schema[7.0].define(version: 2023_07_13_060316) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string "title"
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_chapters_on_book_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "title"
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_sections_on_chapter_id"
  end

  create_table "text_items", force: :cascade do |t|
    t.integer "text_number"
    t.integer "paragraph"
    t.bigint "section_id", null: false
    t.bigint "chapter_id", null: false
    t.bigint "book_id", null: false
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.vector "embedding", limit: 1536
    t.index ["book_id"], name: "index_text_items_on_book_id"
    t.index ["chapter_id"], name: "index_text_items_on_chapter_id"
    t.index ["section_id"], name: "index_text_items_on_section_id"
  end

  add_foreign_key "chapters", "books"
  add_foreign_key "sections", "chapters"
  add_foreign_key "text_items", "books"
  add_foreign_key "text_items", "chapters"
  add_foreign_key "text_items", "sections"
end
