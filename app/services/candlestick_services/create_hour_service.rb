require "active_record"
require "activerecord-import"

module CandlestickServices
  class CreateHourService
    include Common::CreateCandlestick

    attr_accessor :merchandise_rate_ids

    def initialize(merchandise_rate_ids = MERCHANDISE_RATE_IDS)
      @merchandise_rate_ids = merchandise_rate_ids
    end

    def execute
      create_data
      CandlestickHour.delete_duplicate
      validate_data
    end

    private
    # b1: Kiem tra xem ngay cuoi cung co phai cua thang truoc khong, neu phai thi lay data ve
    # b2: Lay ngay bat dau nhan data tu tren Binance Api
    def create_data
      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find_by(id: merchandise_rate_id)
        return unless merchandise_rate.present?

        start_time = get_start_date merchandise_rate
        return if check_hour_is_current_hour(start_time)

        b_data = get_binance_data(merchandise_rate, start_time.to_time.to_i) if start_time.present?
        candlestick_records = build_candlestick_records(merchandise_rate, b_data) if b_data.present?

        if candlestick_records.present?
          ActiveRecord::Base.transaction do
            CandlestickHour.import(candlestick_records, validate: false)
          end
        end
      end
    end

    def validate_data
      result = {}

      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find(merchandise_rate_id)
        result[merchandise_rate_id] = {}
        result[merchandise_rate_id]["name"] = merchandise_rate.slug
        result[merchandise_rate_id]["last_date_update"] = get_start_date(merchandise_rate).to_date
        result[merchandise_rate_id]["validate"] = DataValidations::CandlestickHourValidationService.new(merchandise_rate_id).execute
      end

      result
    end

    # Kiem tra xem ngay cuoi cung trong bang la cua thang truoc
    def check_hour_is_current_hour date
      Time.now.strftime("%Y%m%d%H") === date.strftime("%Y%m%d%H")
    end

    # b1: lay ngay cuoi cung trong database
    # b2: tu ngay cuoi cung, lay ngay tiep theo
    def get_start_date merchandise_rate
      last_candlestick = merchandise_rate.candlestick_hours.sort_by_type.first
      start_time = if last_candlestick.present?
        (last_candlestick.date + 1.hour)
      else
        Time.at(FIRST_DATE_IN_BINANCE[merchandise_rate.base.slug.to_sym]).to_datetime
      end

      start_time
    end

    def get_binance_data merchandise_rate, time
      records = []
      period = (Time.zone.now.to_datetime - Time.at(time).to_datetime).to_i
      period_loop = 1000/24
      loop_number = period/period_loop
      (0..(loop_number+1)).each do |num|
        start_time = (Time.at(time).to_datetime + period_loop*num).to_datetime.to_i
        records << BinanceServices::Request.send!(
          path: "/api/v3/klines",
          params: { symbol: "#{merchandise_rate.slug.upcase}",
          interval: "1h",
          startTime: "#{start_time}000", limit: "1000" }
        )
      end
      records = records.flatten(1)
      records.uniq!
      records
    end

    def build_candlestick_records merchandise_rate, b_data
      candlestick_records = []
      b_data.each do |record|
        record_date = Time.at(record[0]/1000).to_datetime
        next if check_hour_is_current_hour record_date
        hour = record_date.strftime("%H").to_i
        date_with_binane = hour < 7 ? record_date - 1.days : record_date

        open = record[1].to_f
        high = record[2].to_f
        low = record[3].to_f
        close = record[4].to_f

        parent_id = CandlestickDate.find_by(date: date_with_binane)&.id

        candlestick_records.push({
          merchandise_rate_id: merchandise_rate.id,
          date: record_date,
          date_with_binance: date_with_binane,
          hour: hour,
          candlestick_type: open > close ? "decrease" : "increase",
          return_oc: ((close - open)/open).round(4)*100,
          return_hl: ((high - low)/low).round(4)*100,
          open: open,
          high: high,
          low: low,
          close: close,
          volumn: record[5],
          timestamp: record[0],
          parent_id: parent_id,
        })
      end

      candlestick_records
    end
  end
end
