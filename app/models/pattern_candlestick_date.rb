# == Schema Information
#
# Table name: pattern_candlestick_dates
#
#  id                  :bigint           not null, primary key
#  pattern_id          :bigint           not null
#  candlestick_date_id :bigint           not null
#  merchandise_rate_id :bigint           not null
#  date                :date
#  result              :string(45)
#  pattern_note        :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class PatternCandlestickDate < ApplicationRecord
  belongs_to :pattern
  belongs_to :candlestick_date
  belongs_to :merchandise_rate

  class << self
    def delete_duplicate
      PatternCandlestickDate.where.not(id: PatternCandlestickDate.group(:pattern_id, :candlestick_date_id, :date).select("min(id)")).destroy_all
    end
  end
end
