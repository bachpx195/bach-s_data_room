module DataValidations
  class CandlestickDateValidationService
    attr_accessor :merchandise_rate_id

    def initialize merchandise_rate_id
      @merchandise_rate_id = merchandise_rate_id
    end

    def execute
      result = {}

      result[:check_uniq] = check_uniq merchandise_rate_id
      result[:check_missing_date] = check_missing_date merchandise_rate_id
      result
    end

    private
    def check_uniq merchandise_rate_id
      arr = CandlestickDate.where(merchandise_rate_id: merchandise_rate_id).pluck(:date)
      arr.length == arr.uniq.length
    end

    def check_missing_date merchandise_rate_id
      date_arr = CandlestickDate.where(merchandise_rate_id: merchandise_rate_id).order(date: :asc).pluck(:date)
      date_missing = []
      date_arr.each_with_index do |date, index|
        if index != date_arr.length - 1
          date_missing << date + 1.days if (date + 1.days).strftime("%Y%m%d") != date_arr[index + 1].strftime("%Y%m%d")
        end
      end

      date_missing
    end
  end
end