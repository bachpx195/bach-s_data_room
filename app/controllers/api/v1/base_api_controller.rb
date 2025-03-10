class Api::V1::BaseApiController < ActionController::Base
  TIME_TYPES = {
    "1": "day",
    "2": "week",
    "3": "month",
    "4": "hour"
  }

  def candlestick_class time_type
    if time_type.kind_of? String
      time_type_format = time_type
    else
      time_type_format = TIME_TYPES["#{time_type}"]
    end
    c_class = if time_type_format == "month"
      CandlestickMonth
    elsif time_type_format == "hour"
      CandlestickHour
    elsif time_type_format == "week"
      CandlestickWeek
    else
      CandlestickDate
    end

    c_class
  end
end
