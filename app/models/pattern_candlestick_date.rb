# == Schema Information
#
# Table name: pattern_candlestick_dates
#
#  id                  :bigint           not null, primary key
#  pattern_id          :bigint           not null
#  candlestick_date_id :bigint           not null
#  merchandise_rate_id :bigint           not null
#  date                :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class PatternCandlestickDate < ApplicationRecord
  belongs_to :pattern
  belongs_to :candlestick_date
  belongs_to :merchandise_rate
end
