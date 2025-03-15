require "active_record"

module CandlestickServices
  class CreateLabelService
    include Common::CreateCandlestick

    attr_accessor :merchandise_rate_ids, :labels

    def initialize(merchandise_rate_ids = MERCHANDISE_RATE_IDS)
      @merchandise_rate_ids = merchandise_rate_ids
      @labels = find_or_create_label
    end

    def execute
      result = {}
      create_data
      delete_duplicate

      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find(merchandise_rate_id)
        result[merchandise_rate_id] = {}
        result[merchandise_rate_id]["name"] = merchandise_rate.slug
        labels.values.each do |label|
          result[merchandise_rate_id]["last update #{label.name}"] = Time.at(last_time_update_label(merchandise_rate, label, "candlestick_hour").to_i/1000).to_datetime
        end
      end
      result
    end

    def label_for_candlestick merchandise_rate, label
      candlestick_dates = merchandise_rate.candlestick_dates
      date_records = []
      candlestick_dates = candlestick_dates.where("timestamp > ?", last_time_update_label(merchandise_rate, label, "candlestick_date"))
      build_label_candlestick date_records, candlestick_dates, label, merchandise_rate, "candlestick_date_id"
      if date_records.present?
        ActiveRecord::Base.transaction do
          LabelCandlestickDate.import(date_records)
        end
      end

      # Hour
      candlestick_hours = merchandise_rate.candlestick_hours
      hour_records = []
      candlestick_hours = candlestick_hours.where("timestamp > ?", last_time_update_label(merchandise_rate, label, "candlestick_hour"))
      build_label_candlestick hour_records, candlestick_hours, label, merchandise_rate,  "candlestick_hour_id"
      if hour_records.present?
        ActiveRecord::Base.transaction do
          LabelCandlestickHour.import(hour_records)
        end
      end

      # week
      candlestick_weeks = merchandise_rate.candlestick_weeks
      week_records = []
      candlestick_weeks = candlestick_weeks.where("timestamp > ?", last_time_update_label(merchandise_rate, label, "candlestick_week"))
      build_label_candlestick week_records, candlestick_weeks, label, merchandise_rate,  "candlestick_week_id"
      if week_records.present?
        ActiveRecord::Base.transaction do
          LabelCandlestickWeek.import(week_records)
        end
      end

      # month
      candlestick_months = merchandise_rate.candlestick_months
      month_records = []
      candlestick_months = candlestick_months.where("timestamp > ?", last_time_update_label(merchandise_rate, label, "candlestick_month"))
      build_label_candlestick month_records, candlestick_months, label, merchandise_rate,  "candlestick_month_id"
      if month_records.present?
        ActiveRecord::Base.transaction do
          LabelCandlestickMonth.import(month_records)
        end
      end
    end

    private
    def delete_duplicate
      LabelCandlestickWeek.delete_duplicate
      LabelCandlestickDate.delete_duplicate
      LabelCandlestickHour.delete_duplicate
      LabelCandlestickMonth.delete_duplicate
    end

    def find_or_create_label
      labels = {}

      # common label
      labels[:is_inside] = Label.find_or_create_by(name: "Trong biên độ", slug: "is_inside")
      labels[:is_different_from_btc] = Label.find_or_create_by(name: "Khac chiều với BTC", slug: "is_different_from_btc")

      labels
    end

    def create_data
      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find_by(id: merchandise_rate_id)
        return unless merchandise_rate.present?

        # Date
        candlestick_dates = merchandise_rate.candlestick_dates
        date_records = []
        labels.values.each do |label|
          candlestick_dates = candlestick_dates.where("timestamp > ?", last_time_update_label(merchandise_rate, label, "candlestick_date"))
          build_label_candlestick date_records, candlestick_dates, label, merchandise_rate, "candlestick_date_id"
        end
        if date_records.present?
          ActiveRecord::Base.transaction do
            LabelCandlestickDate.import(date_records)
          end
        end

        # Hour
        candlestick_hours = merchandise_rate.candlestick_hours
        hour_records = []
        labels.values.each do |label|
          candlestick_hours = candlestick_hours.where("timestamp > ?", last_time_update_label(merchandise_rate, label, "candlestick_hour"))
          build_label_candlestick hour_records, candlestick_hours, label, merchandise_rate,  "candlestick_hour_id"
        end
        if hour_records.present?
          ActiveRecord::Base.transaction do
            LabelCandlestickHour.import(hour_records)
          end
        end

        # week
        candlestick_weeks = merchandise_rate.candlestick_weeks
        week_records = []
        labels.values.each do |label|
          candlestick_weeks = candlestick_weeks.where("timestamp > ?", last_time_update_label(merchandise_rate, label, "candlestick_week"))
          build_label_candlestick week_records, candlestick_weeks, label, merchandise_rate,  "candlestick_week_id"
        end
        if week_records.present?
          ActiveRecord::Base.transaction do
            LabelCandlestickWeek.import(week_records)
          end
        end

        # month
        candlestick_months = merchandise_rate.candlestick_months
        month_records = []
        labels.values.each do |label|
          candlestick_months = candlestick_months.where("timestamp > ?", last_time_update_label(merchandise_rate, label, "candlestick_month"))
          build_label_candlestick month_records, candlestick_months, label, merchandise_rate,  "candlestick_month_id"
        end
        if month_records.present?
          ActiveRecord::Base.transaction do
            LabelCandlestickMonth.import(month_records)
          end
        end
      end
    end

    def build_label_candlestick(records, candlestick, label, merchandise_rate, candlestick_type)
      if label.slug == "is_inside"
        build_is_inside records, candlestick, merchandise_rate, candlestick_type
      elsif label.slug == "is_different_from_btc"
        build_is_different_from_btc records, candlestick, merchandise_rate, candlestick_type
      end

      records
    end

    def build_is_inside(records, candlestick, merchandise_rate, candlestick_type)
      candlestick.each do |c|
        next if !c.is_inside?
        record_hash = {
          label_id: labels[:is_inside].id,
          merchandise_rate_id: merchandise_rate.id
        }
        record_hash[candlestick_type.to_sym] = c.id

        records.push(record_hash)
      end

      records
    end

    def build_is_different_from_btc records, candlestick, merchandise_rate, candlestick_type
      return records if merchandise_rate.is_btc?

      candlestick.each do |c|
        next if c.is_same_btc?

        record_hash = {
          label_id: labels[:is_different_from_btc].id,
          merchandise_rate_id: merchandise_rate.id
        }
        record_hash[candlestick_type.to_sym] = c.id

        records.push(record_hash)
      end

      records
    end

    def not_label_yet(merchandise_rate, label, candlestick_type)
      merchandise_rate.send(candlestick_type).pluck(:id).uniq
    end

    def last_time_update_label(merchandise_rate, label, candlestick_type)
      last_record = merchandise_rate.send("label_#{candlestick_type}s")
        .joins(candlestick_type.to_sym)
        .find_by_label(label.id)
        .order("#{candlestick_type}s.date desc").first
      if last_record.present?
        last_record.send(candlestick_type.to_sym).timestamp
      else
        0
      end
    end
  end
end
