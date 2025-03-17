module CandlestickCommon
  extend ActiveSupport::Concern

  included do
    scope :date_between, -> start_date, end_date do
      where("date >= ? AND date <= ?", start_date.to_date.beginning_of_day, end_date.to_date.end_of_day)
    end

    scope :sort_by_type, -> sort_type = :desc do
      order(date: sort_type)
    end

    scope :null_parent_id, -> do
      where(parent_id: nil)
    end

    scope :time_between, -> start_time, end_time do
      where("date >= ? AND date <= ?", start_time, end_time )
    end

    scope :find_by_merchandise_rate, -> merchandise_rate_id, limit do
      where(merchandise_rate_id: merchandise_rate_id)
      .limit(limit)
      .sort_by_type
    end
  end

  # Old
  def before_candlestick
    before_date = self.date - 1.send(self.class::C_TYPE)
    self.class.where(merchandise_rate: self.merchandise_rate, date: before_date).first
  end

  def before_candlesticks(number_of_candlestick=1)
    before_date = []
    (1..number_of_candlestick).each do |number|
      before_date << self.date - number.send(self.class::C_TYPE)
    end
    self.class.where(merchandise_rate: self.merchandise_rate, date: before_date).sort_by_type
  end

  def next_candlestick
    before_date = self.date + 1.send(self.class::C_TYPE)
    self.class.where(merchandise_rate: self.merchandise_rate, date: before_date).first
  end

  def btc_candlestick
    self.class.where(merchandise_rate: 34, timestamp: self.timestamp).first
  end

  def is_inside?
    before_c = self.before_candlestick
    return false if !before_c.present?

    self.high < before_c.high && self.low > before_c.low
  end

  def is_same_btc?
    btc_c = self.btc_candlestick
    return true if !btc_c.present?

    btc_c.candlestick_type == self.candlestick_type
  end
end
