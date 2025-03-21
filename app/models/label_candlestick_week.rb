# == Schema Information
#
# Table name: label_candlestick_weeks
#
#  id                  :bigint           not null, primary key
#  label_id            :bigint           not null
#  candlestick_week_id :bigint           not null
#  merchandise_rate_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class LabelCandlestickWeek < ApplicationRecord
  include LabelCandlestickCommon

  belongs_to :label
  belongs_to :candlestick_week
  belongs_to :merchandise_rate

  class << self
    def delete_duplicate
      LabelCandlestickWeek.where.not(id: LabelCandlestickWeek.group(:label_id, :candlestick_week_id).select("min(id)")).destroy_all
    end
  end
end
