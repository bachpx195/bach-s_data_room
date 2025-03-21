# == Schema Information
#
# Table name: label_candlestick_hours
#
#  id                  :bigint           not null, primary key
#  label_id            :bigint           not null
#  candlestick_hour_id :bigint           not null
#  merchandise_rate_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class LabelCandlestickHour < ApplicationRecord
  include LabelCandlestickCommon

  belongs_to :label
  belongs_to :candlestick_hour
  belongs_to :merchandise_rate

  class << self
    def delete_duplicate
      LabelCandlestickHour.where.not(id: LabelCandlestickHour.group(:label_id, :candlestick_hour_id).select("min(id)")).destroy_all
    end
  end
end
