# == Schema Information
#
# Table name: candlestick_weeks
#
#  id                  :bigint           not null, primary key
#  merchandise_rate_id :bigint           not null
#  date                :date
#  candlestick_type    :string(255)
#  return_oc           :float(24)
#  return_hl           :float(24)
#  open                :float(24)
#  high                :float(24)
#  close               :float(24)
#  low                 :float(24)
#  volumn              :float(24)
#  week_master_id      :integer
#  timestamp           :integer
#  parent_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CandlestickWeek < ApplicationRecord
  belongs_to :merchandise_rate
  belongs_to :week_master, optional: true

  class << self
    def delete_duplicate
      CandlestickWeek.where.not(id: CandlestickWeek.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end
  end
end
