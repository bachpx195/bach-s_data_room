# == Schema Information
#
# Table name: label_candlestick_months
#
#  id                   :bigint           not null, primary key
#  label_id             :bigint           not null
#  candlestick_month_id :bigint           not null
#  merchandise_rate_id  :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class LabelCandlestickMonth < ApplicationRecord
  include LabelCandlestickCommon

  belongs_to :label
  belongs_to :candlestick_month
  belongs_to :merchandise_rate

  class << self
    def delete_duplicate
      LabelCandlestickMonth.where.not(id: LabelCandlestickMonth.group(:label_id, :candlestick_month_id).select("min(id)")).destroy_all
    end
  end
end
