class Label < ApplicationRecord
  has_many :label_candlestick_dates
  has_many :candlestick_dates, through: :label_candlestick_dates

  has_many :label_candlestick_months
  has_many :candlestick_months, through: :label_candlestick_months

  has_many :label_candlestick_hours
  has_many :candlestick_hours, through: :label_candlestick_hours

  has_many :label_candlestick_weeks
  has_many :candlestick_weeks, through: :label_candlestick_weeks
end
