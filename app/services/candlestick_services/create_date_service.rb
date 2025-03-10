require "active_record"
require "activerecord-import"

module CandlestickServices
  class CreateDateService
    include Common::CreateCandlestick

    attr_accessor :merchandise_rate_ids

    def initialize(merchandise_rate_ids = MERCHANDISE_RATE_IDS)
      @merchandise_rate_ids = merchandise_rate_ids
    end

    def execute
      create_data
      CandlestickDate.delete_duplicate
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
        return if check_date_is_current_date(start_time)

        b_data = get_binance_data(merchandise_rate, start_time.to_time.to_i) if start_time.present?
        candlestick_records = build_candlestick_records(merchandise_rate, b_data) if b_data.present?

        if candlestick_records.present?
          ActiveRecord::Base.transaction do
            CandlestickDate.import(candlestick_records, validate: false)
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
        result[merchandise_rate_id]["validate"] = DataValidations::CandlestickDateValidationService.new(merchandise_rate_id).execute
      end

      result
    end

    # Kiem tra xem ngay cuoi cung trong bang la cua thang truoc
    def check_date_is_current_date date
      Time.now.strftime("%Y%m%d") === date.strftime("%Y%m%d")
    end

    # b1: lay ngay cuoi cung trong database
    # b2: tu ngay cuoi cung, lay ngay tiep theo
    def get_start_date merchandise_rate
      last_candlestick = merchandise_rate.candlestick_dates.sort_by_type.first
      start_time = if last_candlestick.present?
        (last_candlestick.date + 1.days)
      else
        Time.at(FIRST_DATE_IN_BINANCE[merchandise_rate.base.slug.to_sym]).to_date
      end

      start_time
    end

    def get_binance_data merchandise_rate, time
      records = []
      period = (Time.zone.now.to_datetime - Time.at(time).to_datetime).to_i
      period_loop = 1000
      loop_number = period/period_loop
      (0..loop_number).each do |num|
        start_time = (Time.at(time).to_datetime + period_loop*num).to_datetime.to_i
        records << BinanceServices::Request.send!(
          path: "/api/v3/klines",
          params: { symbol: "#{merchandise_rate.slug.upcase}",
          interval: "1d",
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
        record_date = Time.at(record[0]/1000).to_date
        next if check_date_is_current_date record_date
        open = record[1].to_f
        high = record[2].to_f
        low = record[3].to_f
        close = record[4].to_f

        parent_week_id = CandlestickWeek.find_by(date: record_date.at_beginning_of_week.strftime("%Y-%m-%d"))&.id
        parent_month_id = CandlestickMonth.find_by(year: record_date.year, month: record_date.month)&.id

        candlestick_records.push({
          merchandise_rate_id: merchandise_rate.id,
          date: record_date,
          date_name: record_date.strftime("%A"),
          candlestick_type: open > close ? "decrease" : "increase",
          return_oc: ((close - open)/open).round(4)*100,
          return_hl: ((high - low)/low).round(4)*100,
          open: open,
          high: high,
          low: low,
          close: close,
          volumn: record[5],
          timestamp: record[0],
          parent_id: parent_week_id,
          parent_month_id: parent_month_id
        })
      end

      candlestick_records
    end
  end
end
