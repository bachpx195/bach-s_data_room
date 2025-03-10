
module CandlestickServices
  class CreateService
    include Common::CreateCandlestick

    attr_accessor :merchandise_rate_ids, :interval

    def initialize(merchandise_rate_ids = MERCHANDISE_RATE_IDS, interval = nil)
      @merchandise_rate_ids = merchandise_rate_ids
      @interval = interval
    end

    # b1: Lay data tu binance ve roi luu vao database
    # b2: update parent id
    def execute
      result = {
        "month": [],
        "week": [],
        "date": [],
        "hour": [],
      }
      if interval.present?
        result[interval] = if interval == "month"
          CandlestickServices::CreateMonthService.new(merchandise_rate_ids).execute
        elsif interval == "week"
          CandlestickServices::CreateWeekService.new(merchandise_rate_ids).execute
        elsif interval == "hour"
          CandlestickServices::CreateHourService.new(merchandise_rate_ids).execute
        else
          CandlestickServices::CreateDateService.new(merchandise_rate_ids).execute
        end
      else
        result["month"] = CandlestickServices::CreateMonthService.new(merchandise_rate_ids).execute
        result["week"] = CandlestickServices::CreateWeekService.new(merchandise_rate_ids).execute
        result["date"] = CandlestickServices::CreateDateService.new(merchandise_rate_ids).execute
        result["hour"] = CandlestickServices::CreateHourService.new(merchandise_rate_ids).execute
      end

      CandlestickServices::UpdateParentIdService.new.execute
      result
    end
  end
end
