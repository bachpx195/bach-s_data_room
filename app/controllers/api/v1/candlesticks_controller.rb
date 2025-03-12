class Api::V1::CandlesticksController < Api::V1::BaseApiController
  before_action :set_candlestick, only: [:info]

  def index
    limit_records = 10000
    merchandise_rate_id = params[:merchandise_rate_id]
    time_type = params[:time_type].to_i

    # @candlesticks là các cây nến trong thời gian hiện tại (lấy limit_records cây)
    # @candlesticks_future là các cây nến trong thời gian tương lai để làm backtest (lấy thêm limit_records cây trong tương lai)
    if params[:date].present?
      date = params[:date].to_datetime
      start_date, end_date, next_date = candlestick_class(time_type).range_between_date date, limit_records
      @candlesticks = candlestick_class(time_type).find_by_merchandise_rate(merchandise_rate_id.to_i, limit_records)
        .time_between(start_date, date)
        .sort_by{|c| c.timestamp}
      @candlesticks_future = candlestick_class(time_type).find_by_merchandise_rate(merchandise_rate_id.to_i, limit_records)
        .time_between(next_date, end_date)
        .sort_by{|c| c.timestamp}
    else
      @candlesticks = candlestick_class(time_type).find_by_merchandise_rate(merchandise_rate_id.to_i, limit_records)
        .sort_by{|c| c.timestamp}
      @candlesticks_future = []
    end
  end

  def date_and_hour
    limit_records = 10000
    merchandise_rate_id = params[:merchandise_rate_id]
    time_type = params[:time_type].to_i

    # @candlesticks là các cây nến trong thời gian hiện tại (lấy limit_records cây)
    # @candlesticks_future là các cây nến trong thời gian tương lai để làm backtest (lấy thêm limit_records cây trong tương lai)
    if params[:date].present?
      date = params[:date].to_datetime
      start_date, end_date, next_date = candlestick_class(time_type).range_between_date date, limit_records
      @candlesticks_date = CandlestickDate.find_by_merchandise_rate(merchandise_rate_id.to_i, limit_records)
        .time_between(start_date, date - 1.days)
        .sort_by{|c| c.timestamp}

      @candlesticks_hour = CandlestickHour.where(merchandise_rate_id: merchandise_rate_id.to_i)
        .where(date_with_binance: params[:date])
        .sort_by{|c| c.timestamp}
      @candlesticks_future = []
    else
      last_date = CandlestickDate.where(merchandise_rate_id: merchandise_rate_id.to_i).sort_by_type.first.date
      @candlesticks = CandlestickDate.find_by_merchandise_rate(merchandise_rate_id.to_i, 30)
        .where("date < ?", last_date)
        .sort_by{|c| c.timestamp}

      @candlesticks_hour = CandlestickHour.where(merchandise_rate_id: merchandise_rate_id.to_i)
        .where(date_with_binance: last_date)
        .sort_by{|c| c.timestamp}

      @candlesticks_future = []
    end
  end

  def async_update_data
    time_type = params["time_type"]
    result = true

    if time_type.present?
      result = CandlestickServices::CreateService.new(params["merchandise_rate_ids"], TIME_TYPES[:"#{params["time_type"]}"]).execute
    else
      result = CandlestickServices::CreateService.new(params["merchandise_rate_ids"]).execute
    end

    render json: result
  end

  def merchandise_rates
    time_type = params[:time_type]
    list_merchandise_rate_ids = candlestick_class(time_type).list_merchandise_rate_id(time_type)
    id_json = {}
    list_merchandise_rate_ids.each do |id|
      id_json[id.first] = MerchandiseRate.find(id.first).slug
    end

    render json: id_json
  end

  # https://github.com/bachpx195/the_big_trade/issues/42
  def monthly_return
    merchandise_rate_id = params[:merchandise_rate_id]
    using_markdown_text = params[:using_markdown_text]

    monthly_return_json = CandlestickMonth.calculate_month_return merchandise_rate_id, using_markdown_text

    render json: monthly_return_json
  end

  def info
    info_json = {}
    timestamp = @candlestick.timestamp

    if params["info_type"] == "day"

      info_json[:close] = @candlestick&.close
      info_json[:return_day] = @candlestick&.return_oc
      info_json[:return_oc] = @candlestick&.return_oc
      info_json[:return_hl] = @candlestick&.return_hl

      btc_candlestick = @candlestick_class.where(merchandise_rate_id: 34, timestamp: timestamp).last
      info_json[:btc_return_day] = btc_candlestick.return_oc
      info_json[:btc_close] = btc_candlestick&.close

      altbtc_candlestick = @candlestick_class.where(merchandise_rate_id: 41, timestamp: timestamp).last
      info_json[:altbtc_return_day] = altbtc_candlestick.return_oc
      info_json[:altbtc_close] = altbtc_candlestick&.close
    else
      previous_day = CandlestickDate.find_by(merchandise_rate_id: @candlestick.merchandise_rate_id, date: @candlestick.date_with_binance - 1.days)
      timestamp = previous_day.timestamp
      previous_24_hour = @candlestick.previous_24_hour
      previous_24_hour_timestamp = previous_24_hour.timestamp
      day_open = previous_day.close

      btc_candlestick = CandlestickHour.where(merchandise_rate_id: 34, timestamp: timestamp).last
      btc_previous_day = CandlestickDate.where(merchandise_rate_id: 34, timestamp: timestamp).last
      btc_previous_24_hour = CandlestickHour.where(merchandise_rate_id: 34, timestamp: previous_24_hour_timestamp).last
      btc_day_open = btc_previous_day.close

      altbtc_candlestick = CandlestickHour.where(merchandise_rate_id: 41, timestamp: timestamp).last
      altbtc_previous_day = CandlestickDate.where(merchandise_rate_id: 41, timestamp: timestamp).last
      altbtc_previous_24_hour = CandlestickHour.where(merchandise_rate_id: 41, timestamp: previous_24_hour_timestamp).last
      altbtc_day_open = altbtc_previous_day.close

      info_json[:return_day] = ((@candlestick.close - day_open)*100/day_open).round(2)
      info_json[:return_24h] = ((@candlestick.close - previous_24_hour.close)*100/previous_24_hour.close).round(2)
      info_json[:close] = @candlestick&.close
      info_json[:return_oc] = @candlestick&.return_oc
      info_json[:return_hl] = @candlestick&.return_hl

      info_json[:btc_return_day] = ((btc_candlestick.close - btc_day_open)*100/btc_day_open).round(2)
      info_json[:btc_return_24h] = ((btc_candlestick.close - btc_previous_24_hour.close)*100/btc_previous_24_hour.close).round(2)
      info_json[:btc_close] = btc_candlestick&.close

      info_json[:altbtc_return_day] = ((altbtc_candlestick.close - altbtc_day_open)*100/altbtc_day_open).round(2)
      info_json[:altbtc_return_24h] = ((altbtc_candlestick.close - altbtc_previous_24_hour.close)*100/altbtc_previous_24_hour.close).round(2)
      info_json[:altbtc_close] = altbtc_candlestick&.close
    end
    
    render json: info_json
  end

  private
  def set_candlestick
    if params["info_type"] == "day"
      @candlestick_class = CandlestickDate
    else
      @candlestick_class = CandlestickHour
    end
    @candlestick = @candlestick_class.find(params[:id])
  end
end
