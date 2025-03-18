require "active_record"

# Muc dich
# Update parent id cua cac candlestick
module CandlestickServices
  class UpdateRangeTypeService
    include Common::CreateCandlestick

    attr_accessor :merchandise_rate_ids

    def initialize(merchandise_rate_ids = MERCHANDISE_RATE_IDS)
      @merchandise_rate_ids = merchandise_rate_ids
    end

    # b2: Kiem tra cac candlestick nao chua co range type va update
    def execute
      [ "candlestick_date", "candlestick_hour", "candlestick_month", "candlestick_week" ].each do |c_type|
        c_type.camelize.constantize.null_range_type.each {|x| x.update_range_type} if c_type.camelize.constantize.null_range_type.present?
      end
    end
  end
end
