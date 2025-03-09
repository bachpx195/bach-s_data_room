# == Schema Information
#
# Table name: candlestick_hours
#
#  id                  :bigint           not null, primary key
#  merchandise_rate_id :bigint           not null
#  date                :datetime
#  date_with_binance   :date
#  hour                :integer
#  candlestick_type    :string(255)
#  return_oc           :float(24)
#  return_hl           :float(24)
#  open                :float(24)
#  high                :float(24)
#  close               :float(24)
#  low                 :float(24)
#  volumn              :float(24)
#  timestamp           :integer
#  parent_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CandlestickHour < ApplicationRecord
  include CandlestickCommon

  belongs_to :merchandise_rate

  class << self
    def delete_duplicate
      CandlestickHour.where.not(id: CandlestickHour.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end
  end
end
