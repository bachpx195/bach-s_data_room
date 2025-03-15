require "active_record"

module PatternServices
  class CreatePatternService
    attr_accessor :merchandise_rate, :pattern

    def initialize(pattern_id)
      @pattern = Pattern.find(pattern_id)
      @merchandise_rate = @pattern.merchandise_rate
    end

    def execute
      result = {}
      create_data
      PatternCandlestickDate.delete_duplicate

      result["name"] = merchandise_rate.slug
      result["last update #{pattern.name}"] = Time.at(last_time_update_pattern("candlestick_date").to_i/1000).to_datetime
      result
    end

    private
    def create_data
      # Date
      candlestick_dates = merchandise_rate.candlestick_dates.where("timestamp > ?", last_time_update_pattern("candlestick_date"))
      records = []
      records = build_pattern_candlestick candlestick_dates

      if records.present?
        ActiveRecord::Base.transaction do
          PatternCandlestickDate.import(records)
        end
      end
    end

    def build_pattern_candlestick(candlesticks)
      records = if pattern.slug == "CL_001_ALL"
        build_cl_001 candlesticks
      end

      records
    end

    # https://github.com/bachpx195/bach-s_trading_room/issues/75
    def build_cl_001 candlesticks
      records = []

      candlesticks.each do |c_date|
        is_cl_001_high_pattern = c_date.is_cl_001_high_pattern?
        is_cl_001_low_pattern = c_date.is_cl_001_low_pattern?
        next if !is_cl_001_high_pattern && !is_cl_001_low_pattern
        pattern_id = if is_cl_001_high_pattern && is_cl_001_low_pattern
          Pattern.find_by(slug: "CL_001_high_low").id
        elsif is_cl_001_high_pattern
          Pattern.find_by(slug: "CL_001_high").id
        else
          Pattern.find_by(slug: "CL_001_low").id
        end

        record_hash = {
          pattern_id: pattern_id,
          merchandise_rate_id: merchandise_rate.id,
          date: c_date.date,
          candlestick_date_id: c_date.id
        }

        records.push(record_hash)
      end

      records
    end

    def last_time_update_pattern(candlestick_type="candlestick_date")
      last_record = merchandise_rate.send("pattern_#{candlestick_type}s")
        .joins(candlestick_type.to_sym)
        .where("pattern_#{candlestick_type}s.pattern_id in (?)", pattern.child_patterns.pluck(:id))
        .order("#{candlestick_type}s.date desc").first
      if last_record.present?
        last_record.send(candlestick_type.to_sym).timestamp
      else
        0
      end
    end
  end
end
