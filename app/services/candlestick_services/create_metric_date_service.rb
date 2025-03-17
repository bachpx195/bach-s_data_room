require "active_record"
require "activerecord-import"

module CandlestickServices
  class CreateMetricDateService
    include Common::CreateCandlestick

    attr_accessor :merchandise_rate_ids

    def initialize(merchandise_rate_ids = MERCHANDISE_RATE_IDS)
      @merchandise_rate_ids = merchandise_rate_ids
    end

    def execute
      create_data
      remove_metric_of_deleted_candlestick
      validate_data
    end

    private
    # b1: Kiem tra xem nhung candlestick nao chua co metric => tinh metric cho nhung candlestick do
    def create_data
      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find_by(id: merchandise_rate_id)
        return unless merchandise_rate.present?

        candlestick_dates = CandlestickDate.where(id: not_metric_yet(merchandise_rate))
        records = build_metric merchandise_rate, candlestick_dates

        if records.present?
          ActiveRecord::Base.transaction do
            MetricDate.import(records, validate: false)
          end
        end
      end
    end

    def remove_metric_of_deleted_candlestick
      MetricDate.where(id: MetricDate.pluck(:candlestick_date_id) - CandlestickDate.pluck(:id)).delete_all
    end

    def not_metric_yet merchandise_rate
      merchandise_rate.candlestick_dates.pluck(:id).uniq - merchandise_rate.metric_dates.pluck(:candlestick_date_id).uniq
    end

    def validate_data
      result = {}

      merchandise_rate_ids.each do |merchandise_rate_id|
        merchandise_rate = MerchandiseRate.find(merchandise_rate_id)
        result[merchandise_rate_id] = {}
        result[merchandise_rate_id]["name"] = merchandise_rate.slug
        result[merchandise_rate_id]["not_metric"] = CandlestickDate.where(id: not_metric_yet(merchandise_rate)).pluck(:date)
      end

      result
    end

    # Khong tinh metric voi nhung candlestick chua du 24h
    def build_metric(merchandise_rate, data)
      records = []
      data.each do |record|
        next if record.candlestick_hours.count < 24
        tmp_highest_hour_return_hl = nil
        highest_return_hl = 0

        tmp_highest_hour_return_oc = nil
        highest_return_oc = 0

        tmp_highest_hour_volumn = nil
        highest_volumn = 0

        tmp_reverse_increase_hour = nil
        highest = 0

        tmp_reverse_decrease_hour = nil
        lowest = 10000000

        record.candlestick_hours.each do |ch|
          hour = ch.hour

          # reverse_decrease_hour
          if ch.low < lowest
            tmp_reverse_decrease_hour = hour
            lowest = ch.low
          end

          # reverse_increase_hour
          if ch.high > highest
            tmp_reverse_increase_hour = hour
            highest = ch.high
          end

          # highest_hour_return_hl
          if ch.return_hl > highest_return_hl
            tmp_highest_hour_return_hl = hour
            highest_return_hl = ch.return_hl
          end

          # highest_hour_return
          if ch.return_oc.abs > highest_return_oc
            tmp_highest_hour_return_oc = hour
            highest_return_oc = ch.return_oc.abs
          end

          # highest_hour_volumn
          if ch.volumn > highest_volumn
            tmp_highest_hour_volumn = hour
            highest_volumn = ch.volumn
          end
        end

        records.push({
          merchandise_rate_id: merchandise_rate.id,
          candlestick_date_id: record.id,
          highest_hour_return_oc: tmp_highest_hour_return_oc,
          highest_hour_return_hl: tmp_highest_hour_return_hl,
          reverse_decrease_hour: tmp_reverse_decrease_hour,
          reverse_increase_hour: tmp_reverse_increase_hour,
          highest_hour_volumn: tmp_highest_hour_volumn
        })
      end

      records
    end
  end
end
