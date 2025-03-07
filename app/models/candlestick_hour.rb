# == Schema Information
#
# Table name: candlestick_hours
#
#  id                  :bigint           not null, primary key
#  merchandise_rate_id :bigint           not null
#  date                :datetime
#  open                :float(24)
#  high                :float(24)
#  close               :float(24)
#  low                 :float(24)
#  volumn              :float(24)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CandlestickHour < ApplicationRecord
  belongs_to :merchandise_rate

  class << self
    def delete_duplicate
      CandlestickHour.where.not(id: CandlestickHour.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end
  end
end
