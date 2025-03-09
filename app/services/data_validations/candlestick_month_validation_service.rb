module DataValidations
  class CandlestickMonthValidationService
    attr_accessor :merchandise_rate_id

    def initialize merchandise_rate_id
      @merchandise_rate_id = merchandise_rate_id
    end

    def execute
      result = {}

      result[:check_uniq] = check_uniq merchandise_rate_id
      result[:check_missing_month] = check_missing_month merchandise_rate_id
      result
    end

    private
    def check_uniq merchandise_rate_id
      arr = CandlestickMonth.where(merchandise_rate_id: merchandise_rate_id).pluck(:date)
      arr.length == arr.uniq.length
    end

    def check_missing_month merchandise_rate_id
      month_arr = CandlestickMonth.where(merchandise_rate_id: merchandise_rate_id).order(date: :asc).pluck(:date)
      month_missing = []
      month_arr.each_with_index do |month, index|
        if index != month_arr.length - 1
          month_missing << month + 1.months if (month + 1.months).strftime("%Y%m") != month_arr[index + 1].strftime("%Y%m")
        end
      end

      month_missing
    end
  end
end