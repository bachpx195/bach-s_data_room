# == Schema Information
#
# Table name: label_candlestick_dates
#
#  id                  :bigint           not null, primary key
#  label_id            :bigint           not null
#  candlestick_date_id :bigint           not null
#  merchandise_rate_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class LabelCandlestickDate < ApplicationRecord
  include LabelCandlestickCommon

  belongs_to :label
  belongs_to :candlestick_date
  belongs_to :merchandise_rate
end
