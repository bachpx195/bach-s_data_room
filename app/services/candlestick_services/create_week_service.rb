require "active_record"
require "activerecord-import"

module CandlestickServices
  class CreateWeekService
    include Common::CreateCandlestick

    attr_accessor :merchandise_rate_ids

    def initialize(merchandise_rate_ids = MERCHANDISE_RATE_IDS)
      @merchandise_rate_ids = merchandise_rate_ids
    end

    # b1: tao data btc
    def execute
      create_data
      CandlestickWeek.delete_duplicate
      validate_data
    end

    private
    # b1: Kiem tra xem ngay cuoi cung co phai cua thang truoc khong, neu phai thi lay data ve
    # b2: Lay ngay bat dau nhan data tu tren Binance Api
    def create_data
      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find_by(id: merchandise_rate_id)
        return unless merchandise_rate.present?

        start_time = merchandise_rate_last_candlestick_date merchandise_rate
        return if check_last_date_is_previous_week(start_time)

        b_data = get_binance_data(merchandise_rate, start_time.to_time.to_i) if start_time.present?
        candlestick_records = build_candlestick_records(merchandise_rate, b_data) if b_data.present?

        if candlestick_records.present?
          ActiveRecord::Base.transaction do
            CandlestickWeek.import(candlestick_records, validate: false)
          end
        end
      end
    end

    def merchandise_rate_last_candlestick_date merchandise_rate
      last_candlestick = merchandise_rate.candlestick_weeks.sort_by_type.first
      start_time = if last_candlestick.present?
        (last_candlestick.date + 1.weeks)
      else
        Time.at(FIRST_DATE_IN_BINANCE[merchandise_rate.base.slug.to_sym]).to_datetime
      end

      start_time
    end

    def validate_data
      result = {}

      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find(merchandise_rate_id)
        result[merchandise_rate_id] = {}
        result[merchandise_rate_id]["name"] = merchandise_rate.slug
        result[merchandise_rate_id]["last_week_update"] = merchandise_rate_last_candlestick_date(merchandise_rate).to_date
        result[merchandise_rate_id]["validate"] = DataValidations::CandlestickWeekValidationService.new(merchandise_rate_id).execute
      end

      result
    end

    # Kiem tra xem ngay cuoi cung trong bang la tuan truoc
    def check_last_date_is_previous_week date
      date >= Time.zone.now.at_beginning_of_week - 1.weeks
    end

    def get_binance_data merchandise_rate, start_time
      records = BinanceServices::Request.send!(
        path: "/api/v3/klines",
        params: { symbol: "#{merchandise_rate.slug.upcase}",
        interval: "1w",
        startTime: "#{start_time}000", limit: "1000" }
      )

      records
    end

    def build_candlestick_records merchandise_rate, b_data
      candlestick_records = []
      b_data.each do |record|
        record_date = Time.at(record[0]/1000).to_date
        next if check_last_date_is_previous_week record_date
        open = record[1].to_f
        high = record[2].to_f
        low = record[3].to_f
        close = record[4].to_f

        candlestick_records.push({
          merchandise_rate_id: merchandise_rate.id,
          date: record_date,
          candlestick_type: open > close ? "decrease" : "increase",
          return_oc: ((close - open)/open).round(4)*100,
          return_hl: ((high - low)/low).round(4)*100,
          open: open,
          high: high,
          low: low,
          close: close,
          volumn: record[5],
          week_master_id: WeekMaster.find_by(start_date: record_date.strftime("%Y-%m-%d")).id,
          timestamp: record[0]
        })
      end

      candlestick_records
    end
  end
end
