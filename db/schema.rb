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

ActiveRecord::Schema[7.1].define(version: 2023_12_03_235204) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "code"
    t.string "image_url"
    t.integer "value"
    t.string "suit"
    t.bigint "hand_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hand_id"], name: "index_cards_on_hand_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "deck_url"
    t.string "deck_id"
    t.integer "remaining_cards"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_decks_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "hands", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.string "hand_type"
    t.string "pile_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_hands_on_deck_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "credits"
  end

  add_foreign_key "cards", "hands"
  add_foreign_key "decks", "games"
  add_foreign_key "games", "users"
  add_foreign_key "hands", "decks"
end
