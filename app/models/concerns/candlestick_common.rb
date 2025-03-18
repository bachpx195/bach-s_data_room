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

    scope :null_range_type, -> do
      where(range_oc_type: nil, range_hl_type: nil)
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
    self.class.where(merchandise_rate_id: self.merchandise_rate_id, date: before_date).sort_by_type
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

  # Hàm cập nhật loại biến động (range type) dựa trên dữ liệu candlestick trước đó
  # "low"           # Thấp: Dưới mean - 1 std
  # Trung bình thấp: Từ mean - 1 std đến dưới mean
  # Trung bình cao: Từ mean đến dưới mean + 1 std
  # Cao: Từ mean + 1 std đến dưới mean + 2 std
  # Rất cao: Trên mean + 2 std
  def update_range_type
    before_candlestick_range = self.before_candlesticks.first&.send(self.class::C_RANGE)
    return if !before_candlestick_range.present?

    mean_oc = before_candlestick_range.mean_oc
    mean_hl = before_candlestick_range.mean_hl
    std_hl = before_candlestick_range.standard_deviation_hl
    std_oc = before_candlestick_range.standard_deviation_oc

    range_hl_type = if self.return_hl < (mean_hl - std_hl)
      "low"
    elsif self.return_hl >= (mean_hl - std_hl) && self.return_hl < mean_hl
      "medium_low"
    elsif self.return_hl >= mean_hl && self.return_hl < (mean_hl + std_hl)
      "medium_high"
    elsif self.return_hl >= (mean_hl + std_hl) && self.return_hl < (mean_hl + 2*std_hl)
      "high"
    else
      "very_high"
    end

    range_oc_type = if self.return_oc.abs < (mean_oc - std_oc)
      "low"
    elsif self.return_oc.abs >= (mean_oc - std_oc) && self.return_oc.abs < mean_oc
      "medium_low"
    elsif self.return_oc.abs >= mean_oc && self.return_oc.abs < (mean_oc + std_oc)
      "medium_high"
    elsif self.return_oc.abs >= (mean_oc + std_oc) && self.return_oc.abs < (mean_oc + 2*std_oc)
      "high"
    else
      "very_high"
    end

    self.update(range_hl_type: range_hl_type, range_oc_type: range_oc_type)
  end
end
