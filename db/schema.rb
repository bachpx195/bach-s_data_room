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

ActiveRecord::Schema[7.2].define(version: 2025_03_17_041728) do
  create_table "candlestick_dates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.date "date"
    t.string "date_name"
    t.string "candlestick_type"
    t.float "return_oc"
    t.float "return_hl"
    t.float "open"
    t.float "high"
    t.float "close"
    t.float "low"
    t.float "volumn"
    t.string "timestamp"
    t.integer "parent_id"
    t.integer "parent_month_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_candlestick_dates_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_dates_on_merchandise_rate_id"
    t.index ["parent_id"], name: "index_candlestick_dates_on_parent_id"
    t.index ["parent_month_id"], name: "index_candlestick_dates_on_parent_month_id"
    t.index ["timestamp"], name: "index_candlestick_dates_on_timestamp"
  end

  create_table "candlestick_hours", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.datetime "date"
    t.date "date_with_binance"
    t.integer "hour"
    t.string "candlestick_type"
    t.float "return_oc"
    t.float "return_hl"
    t.float "open"
    t.float "high"
    t.float "close"
    t.float "low"
    t.float "volumn"
    t.string "timestamp"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_candlestick_hours_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_hours_on_merchandise_rate_id"
    t.index ["parent_id"], name: "index_candlestick_hours_on_parent_id"
    t.index ["timestamp"], name: "index_candlestick_hours_on_timestamp"
  end

  create_table "candlestick_months", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.date "date"
    t.integer "month"
    t.integer "year"
    t.string "candlestick_type"
    t.float "return_oc"
    t.float "return_hl"
    t.float "open"
    t.float "high"
    t.float "close"
    t.float "low"
    t.float "volumn"
    t.string "timestamp"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_candlestick_months_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_months_on_merchandise_rate_id"
    t.index ["timestamp"], name: "index_candlestick_months_on_timestamp"
  end

  create_table "candlestick_weeks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id", null: false
    t.date "date"
    t.string "candlestick_type"
    t.float "return_oc"
    t.float "return_hl"
    t.float "open"
    t.float "high"
    t.float "close"
    t.float "low"
    t.float "volumn"
    t.integer "week_master_id"
    t.string "timestamp"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_candlestick_weeks_on_date"
    t.index ["merchandise_rate_id"], name: "index_candlestick_weeks_on_merchandise_rate_id"
    t.index ["timestamp"], name: "index_candlestick_weeks_on_timestamp"
  end

  create_table "date_events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "date_master_id", null: false
    t.bigint "event_master_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.bigint "candlestick_date_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "label_candlestick_dates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "candlestick_date_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_date_id"], name: "index_label_candlestick_dates_on_candlestick_date_id"
    t.index ["label_id"], name: "index_label_candlestick_dates_on_label_id"
    t.index ["merchandise_rate_id"], name: "index_label_candlestick_dates_on_merchandise_rate_id"
  end

  create_table "label_candlestick_hours", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "candlestick_hour_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_hour_id"], name: "index_label_candlestick_hours_on_candlestick_hour_id"
    t.index ["label_id"], name: "index_label_candlestick_hours_on_label_id"
    t.index ["merchandise_rate_id"], name: "index_label_candlestick_hours_on_merchandise_rate_id"
  end

  create_table "label_candlestick_months", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "candlestick_month_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_month_id"], name: "index_label_candlestick_months_on_candlestick_month_id"
    t.index ["label_id"], name: "index_label_candlestick_months_on_label_id"
    t.index ["merchandise_rate_id"], name: "index_label_candlestick_months_on_merchandise_rate_id"
  end

  create_table "label_candlestick_weeks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "candlestick_week_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_week_id"], name: "index_label_candlestick_weeks_on_candlestick_week_id"
    t.index ["label_id"], name: "index_label_candlestick_weeks_on_label_id"
    t.index ["merchandise_rate_id"], name: "index_label_candlestick_weeks_on_merchandise_rate_id"
  end

  create_table "labels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "color"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "metric_dates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "merchandise_rate_id"
    t.bigint "candlestick_date_id"
    t.integer "highest_hour_return_oc"
    t.integer "highest_hour_return_hl"
    t.integer "highest_hour_volumn"
    t.float "hour_range_33_per"
    t.float "hour_range_67_per"
    t.integer "reverse_increase_hour"
    t.integer "reverse_decrease_hour"
    t.integer "continue_increase_hour"
    t.integer "continue_decrease_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_date_id"], name: "index_metric_dates_on_candlestick_date_id"
    t.index ["merchandise_rate_id"], name: "index_metric_dates_on_merchandise_rate_id"
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

  create_table "pattern_candlestick_dates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pattern_id", null: false
    t.bigint "candlestick_date_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.date "date"
    t.string "result", limit: 45
    t.text "pattern_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_date_id"], name: "index_pattern_candlestick_dates_on_candlestick_date_id"
    t.index ["merchandise_rate_id"], name: "index_pattern_candlestick_dates_on_merchandise_rate_id"
    t.index ["pattern_id"], name: "index_pattern_candlestick_dates_on_pattern_id"
  end

  create_table "patterns", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.string "pattern_type"
    t.bigint "merchandise_rate_id", null: false
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchandise_rate_id"], name: "index_patterns_on_merchandise_rate_id"
  end

  create_table "range_candlestick_dates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.float "mean_oc"
    t.float "mean_hl"
    t.float "standard_deviation_oc"
    t.float "standard_deviation_hl"
    t.bigint "candlestick_date_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_date_id"], name: "index_range_candlestick_dates_on_candlestick_date_id"
    t.index ["merchandise_rate_id"], name: "index_range_candlestick_dates_on_merchandise_rate_id"
  end

  create_table "range_candlestick_hours", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "date"
    t.float "mean_oc"
    t.float "mean_hl"
    t.float "standard_deviation_oc"
    t.float "standard_deviation_hl"
    t.bigint "candlestick_hour_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_hour_id"], name: "index_range_candlestick_hours_on_candlestick_hour_id"
    t.index ["merchandise_rate_id"], name: "index_range_candlestick_hours_on_merchandise_rate_id"
  end

  create_table "range_candlestick_months", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.float "mean_oc"
    t.float "mean_hl"
    t.float "standard_deviation_oc"
    t.float "standard_deviation_hl"
    t.bigint "candlestick_month_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_month_id"], name: "index_range_candlestick_months_on_candlestick_month_id"
    t.index ["merchandise_rate_id"], name: "index_range_candlestick_months_on_merchandise_rate_id"
  end

  create_table "range_candlestick_weeks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.float "mean_oc"
    t.float "mean_hl"
    t.float "standard_deviation_oc"
    t.float "standard_deviation_hl"
    t.bigint "candlestick_week_id", null: false
    t.bigint "merchandise_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candlestick_week_id"], name: "index_range_candlestick_weeks_on_candlestick_week_id"
    t.index ["merchandise_rate_id"], name: "index_range_candlestick_weeks_on_merchandise_rate_id"
  end

  create_table "system_configs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key"
    t.string "value"
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

  add_foreign_key "candlestick_dates", "merchandise_rates"
  add_foreign_key "candlestick_hours", "merchandise_rates"
  add_foreign_key "candlestick_months", "merchandise_rates"
  add_foreign_key "candlestick_weeks", "merchandise_rates"
  add_foreign_key "date_events", "date_masters"
  add_foreign_key "date_events", "event_masters"
  add_foreign_key "date_events", "merchandise_rates"
  add_foreign_key "date_masters", "month_masters"
  add_foreign_key "date_masters", "week_masters"
  add_foreign_key "date_masters", "year_masters"
  add_foreign_key "event_masters", "merchandise_rates"
  add_foreign_key "label_candlestick_dates", "candlestick_dates"
  add_foreign_key "label_candlestick_dates", "labels"
  add_foreign_key "label_candlestick_dates", "merchandise_rates"
  add_foreign_key "label_candlestick_hours", "candlestick_hours"
  add_foreign_key "label_candlestick_hours", "labels"
  add_foreign_key "label_candlestick_hours", "merchandise_rates"
  add_foreign_key "label_candlestick_months", "candlestick_months"
  add_foreign_key "label_candlestick_months", "labels"
  add_foreign_key "label_candlestick_months", "merchandise_rates"
  add_foreign_key "label_candlestick_weeks", "candlestick_weeks"
  add_foreign_key "label_candlestick_weeks", "labels"
  add_foreign_key "label_candlestick_weeks", "merchandise_rates"
  add_foreign_key "merchandise_rates", "tags"
  add_foreign_key "merchandises", "tags"
  add_foreign_key "metric_dates", "candlestick_dates"
  add_foreign_key "metric_dates", "merchandise_rates"
  add_foreign_key "month_masters", "year_masters"
  add_foreign_key "pattern_candlestick_dates", "candlestick_dates"
  add_foreign_key "pattern_candlestick_dates", "merchandise_rates"
  add_foreign_key "pattern_candlestick_dates", "patterns"
  add_foreign_key "patterns", "merchandise_rates"
  add_foreign_key "range_candlestick_dates", "candlestick_dates"
  add_foreign_key "range_candlestick_dates", "merchandise_rates"
  add_foreign_key "range_candlestick_hours", "candlestick_hours"
  add_foreign_key "range_candlestick_hours", "merchandise_rates"
  add_foreign_key "range_candlestick_months", "candlestick_months"
  add_foreign_key "range_candlestick_months", "merchandise_rates"
  add_foreign_key "range_candlestick_weeks", "candlestick_weeks"
  add_foreign_key "range_candlestick_weeks", "merchandise_rates"
  add_foreign_key "week_masters", "month_masters"
end
