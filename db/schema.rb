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

ActiveRecord::Schema[7.2].define(version: 2025_03_06_215848) do
  create_table "candlestick_date_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.string "date_name"
    t.string "candlestick_type"
    t.float "return_oc"
    t.float "return_hl"
    t.boolean "is_inside_day"
    t.boolean "is_same_btc"
    t.boolean "is_continue_increase"
    t.boolean "is_continue_decrease"
    t.boolean "is_fake_breakout_increase"
    t.boolean "is_fake_breakout_decrease"
    t.integer "continue_by_day"
    t.bigint "merchandise_rate_id", null: false
    t.bigint "candlestick_date_id", null: false
    t.integer "timestamp"
    t.integer "parent_id"
    t.integer "parent_month_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_date_id"], name: "index_candlestick_date_infos_on_candlestick_date_id"
    t.index ["date"], name: "index_candlestick_date_infos_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_date_infos_on_merchandise_rate_id"
    t.index ["timestamp"], name: "index_candlestick_date_infos_on_timestamp"
  end

  create_table "candlestick_dates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.date "date"
    t.float "open"
    t.float "high"
    t.float "close"
    t.float "low"
    t.float "volumn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_candlestick_dates_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_dates_on_merchandise_rate_id"
  end

  create_table "candlestick_hour_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.date "date_with_binance"
    t.integer "hour"
    t.string "candlestick_type"
    t.float "return_oc"
    t.float "return_hl"
    t.boolean "is_inside_hour"
    t.boolean "is_same_btc"
    t.boolean "is_continue_increase"
    t.boolean "is_continue_decrease"
    t.boolean "is_fake_breakout_increase"
    t.boolean "is_fake_breakout_decrease"
    t.integer "continue_by_day"
    t.integer "continue_by_hour"
    t.bigint "merchandise_rate_id", null: false
    t.bigint "candlestick_hour_id", null: false
    t.integer "timestamp"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_hour_id"], name: "index_candlestick_hour_infos_on_candlestick_hour_id"
    t.index ["date"], name: "index_candlestick_hour_infos_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_hour_infos_on_merchandise_rate_id"
    t.index ["timestamp"], name: "index_candlestick_hour_infos_on_timestamp"
  end

  create_table "candlestick_hours", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.datetime "date"
    t.float "open"
    t.float "high"
    t.float "close"
    t.float "low"
    t.float "volumn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchandise_rate_id"], name: "index_candlestick_hours_on_merchandise_rate_id"
  end

  create_table "candlestick_month_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.string "candlestick_type"
    t.float "return_oc"
    t.float "return_hl"
    t.boolean "is_inside_month"
    t.boolean "is_same_btc"
    t.boolean "is_continue_increase"
    t.boolean "is_continue_decrease"
    t.boolean "is_fake_breakout_increase"
    t.boolean "is_fake_breakout_decrease"
    t.integer "continue_by_year"
    t.integer "continue_by_month"
    t.bigint "merchandise_rate_id", null: false
    t.bigint "candlestick_month_id", null: false
    t.integer "year"
    t.integer "month"
    t.integer "timestamp"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_month_id"], name: "index_candlestick_month_infos_on_candlestick_month_id"
    t.index ["date"], name: "index_candlestick_month_infos_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_month_infos_on_merchandise_rate_id"
    t.index ["timestamp"], name: "index_candlestick_month_infos_on_timestamp"
  end

  create_table "candlestick_months", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.date "date"
    t.float "open"
    t.float "high"
    t.float "close"
    t.float "low"
    t.float "volumn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_candlestick_months_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_months_on_merchandise_rate_id"
  end

  create_table "candlestick_week_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.string "candlestick_type"
    t.float "return_oc"
    t.float "return_hl"
    t.boolean "is_inside_week"
    t.boolean "is_same_btc"
    t.boolean "is_continue_increase"
    t.boolean "is_continue_decrease"
    t.boolean "is_fake_breakout_increase"
    t.boolean "is_fake_breakout_decrease"
    t.integer "continue_by_week"
    t.bigint "merchandise_rate_id", null: false
    t.bigint "candlestick_week_id", null: false
    t.bigint "week_master_id", null: false
    t.integer "timestamp"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_week_id"], name: "index_candlestick_week_infos_on_candlestick_week_id"
    t.index ["date"], name: "index_candlestick_week_infos_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_week_infos_on_merchandise_rate_id"
    t.index ["timestamp"], name: "index_candlestick_week_infos_on_timestamp"
    t.index ["week_master_id"], name: "index_candlestick_week_infos_on_week_master_id"
  end

  create_table "candlestick_weeks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.date "date"
    t.float "open"
    t.float "high"
    t.float "close"
    t.float "low"
    t.float "volumn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_candlestick_weeks_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_weeks_on_merchandise_rate_id"
  end

  create_table "date_events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "date_master_id", null: false
    t.bigint "event_master_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.bigint "candlestick_date_info_id", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_date_info_id"], name: "index_date_events_on_candlestick_date_info_id"
    t.index ["date_master_id"], name: "index_date_events_on_date_master_id"
    t.index ["event_master_id"], name: "index_date_events_on_event_master_id"
    t.index ["merchandise_rate_id"], name: "index_date_events_on_merchandise_rate_id"
  end

  create_table "date_masters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.string "date_name"
    t.integer "date_number"
    t.integer "month"
    t.bigint "month_master_id", null: false
    t.integer "year"
    t.bigint "year_master_id", null: false
    t.bigint "week_master_id", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_date_masters_on_date"
    t.index ["month_master_id"], name: "index_date_masters_on_month_master_id"
    t.index ["week_master_id"], name: "index_date_masters_on_week_master_id"
    t.index ["year_master_id"], name: "index_date_masters_on_year_master_id"
  end

  create_table "event_masters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.string "name"
    t.string "slug"
    t.text "description"
    t.string "time"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchandise_rate_id"], name: "index_event_masters_on_merchandise_rate_id"
  end

  create_table "merchandise_rates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.string "name"
    t.string "slug"
    t.integer "base_id"
    t.integer "quote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_merchandise_rates_on_tag_id"
  end

  create_table "merchandises", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.string "name"
    t.string "slug"
    t.string "founder"
    t.string "company"
    t.string "country"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_merchandises_on_tag_id"
  end

  create_table "month_masters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "start_date"
    t.integer "month"
    t.integer "year"
    t.bigint "year_master_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year_master_id"], name: "index_month_masters_on_year_master_id"
  end

  create_table "system_configs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "week_masters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "start_date"
    t.integer "month"
    t.integer "year"
    t.integer "overlap_month"
    t.integer "number_in_month"
    t.integer "year_master"
    t.bigint "month_master_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["month_master_id"], name: "index_week_masters_on_month_master_id"
  end

  create_table "year_masters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "start_date"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "candlestick_date_infos", "candlestick_dates"
  add_foreign_key "candlestick_date_infos", "merchandise_rates"
  add_foreign_key "candlestick_dates", "merchandise_rates"
  add_foreign_key "candlestick_hour_infos", "candlestick_hours"
  add_foreign_key "candlestick_hour_infos", "merchandise_rates"
  add_foreign_key "candlestick_hours", "merchandise_rates"
  add_foreign_key "candlestick_month_infos", "candlestick_months"
  add_foreign_key "candlestick_month_infos", "merchandise_rates"
  add_foreign_key "candlestick_months", "merchandise_rates"
  add_foreign_key "candlestick_week_infos", "candlestick_weeks"
  add_foreign_key "candlestick_week_infos", "merchandise_rates"
  add_foreign_key "candlestick_week_infos", "week_masters"
  add_foreign_key "candlestick_weeks", "merchandise_rates"
  add_foreign_key "date_events", "candlestick_date_infos"
  add_foreign_key "date_events", "date_masters"
  add_foreign_key "date_events", "event_masters"
  add_foreign_key "date_events", "merchandise_rates"
  add_foreign_key "date_masters", "month_masters"
  add_foreign_key "date_masters", "week_masters"
  add_foreign_key "date_masters", "year_masters"
  add_foreign_key "event_masters", "merchandise_rates"
  add_foreign_key "merchandise_rates", "tags"
  add_foreign_key "merchandises", "tags"
  add_foreign_key "month_masters", "year_masters"
  add_foreign_key "week_masters", "month_masters"
end
