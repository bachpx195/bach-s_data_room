module DataValidations
  class CandlestickHourValidationService
    attr_accessor :merchandise_rate_id

    def initialize merchandise_rate_id
      @merchandise_rate_id = merchandise_rate_id
    end

    def execute
      result = {}

      result[:check_uniq] = check_uniq merchandise_rate_id
      result[:check_missing_hour] = check_missing_hour merchandise_rate_id
      result
    end

    private
    def check_uniq merchandise_rate_id
      arr = CandlestickHour.where(merchandise_rate_id: merchandise_rate_id).pluck(:date)
      arr.length == arr.uniq.length
    end

    def check_missing_hour merchandise_rate_id
      hour_missing = CandlestickHour.where(merchandise_rate_id: 35).group(:date_with_binance).count.select {|key, value| value < 23}
      hour_missing
    end
  end
end