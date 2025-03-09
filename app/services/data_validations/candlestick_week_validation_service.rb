module DataValidations
  class CandlestickWeekValidationService
    attr_accessor :merchandise_rate_id

    def initialize merchandise_rate_id
      @merchandise_rate_id = merchandise_rate_id
    end

    def execute
      result = {}

      result[:check_uniq] = check_uniq merchandise_rate_id
      result[:check_missing_week] = check_missing_week merchandise_rate_id
      result
    end

    private
    def check_uniq merchandise_rate_id
      arr = CandlestickWeek.where(merchandise_rate_id: merchandise_rate_id).pluck(:date)
      arr.length == arr.uniq.length
    end

    def check_missing_week merchandise_rate_id
      week_arr = CandlestickWeek.where(merchandise_rate_id: merchandise_rate_id).order(date: :asc).pluck(:date)
      week_missing = []
      week_arr.each_with_index do |week, index|
        if index != week_arr.length - 1
          week_missing << week + 1.weeks if (week + 1.weeks) != week_arr[index + 1]
        end
      end

      week_missing
    end
  end
end
