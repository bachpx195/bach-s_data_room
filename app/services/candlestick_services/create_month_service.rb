require 'active_record'
require 'activerecord-import'

module CandlestickServices
  class CreateMonthService
    FIRST_DATE_IN_BINANCE = {
      BTC: 1502902800,
      LTC: 1513123200,
      DOT: 1597712400,
      LINK: 1547942400
    }

    MERCHANDISE_RATE_IDS = [
      34, # btc
      35, # ltc
      41, # ltc/btc
      37, # dot
      39, # dot/btc
      42, # link
      43  # link/btc
    ]

    attr_accessor :merchandise_rate_ids

    def initialize merchandise_rate_ids=MERCHANDISE_RATE_IDS
      @merchandise_rate_ids = merchandise_rate_ids
    end

    def execute
      create_data
      {
        lastest_time: lastest_time,
        status: status
      }
    end

    def create_data
      merchandise_rate_ids.each do |merchandise_rate_id|
        candlestick_records = []
        merchandise_rate = MerchandiseRate.find_by(id: merchandise_rate_id)
        return unless merchandise_rate.present?

        last_candlestick = merchandise_rate.candlestick_months.sort_by_type.first

        start_time = if last_candlestick.present?
          (last_candlestick.date + 1.months).to_i
        else
          Time.at(FIRST_DATE_IN_BINANCE[merchandise_rate.base.slug.to_sym]).to_datetime.to_i
        end

        ActiveRecord::Base.transaction do
          start_time = (Time.at(last_time).to_datetime + period_loop*num).to_datetime.to_i
          records = BinanceServices::Request.send!(
            path: "/api/v3/klines",
            params: {symbol: "#{merchandise_rate.slug.upcase}",
            interval: "1M",
            startTime: "#{start_time}000", limit: "1000"}
          )
          records.each do |record|
            record_date = Time.at(record[0]/1000).to_date
            next if Time.now.strftime("%Y%m") == record_date.strftime("%Y%m")
            candlestick_records.push({
              date: record_date,
              open: record[1],
              high: record[2],
              low: record[3],
              close: record[4],
              volumn: record[5],
              merchandise_rate_id: merchandise_rate.id
            })
          end
          CandlestickMonth.import(candlestick_records, validate: false)
          CandlestickMonth.delete_duplicate
        end
      end
    end
  end
end
