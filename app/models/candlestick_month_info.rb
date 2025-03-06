# == Schema Information
#
# Table name: candlestick_month_infos
#
#  id                        :bigint           not null, primary key
#  date                      :date
#  candlestick_type          :string(255)
#  return_oc                 :float(24)
#  return_hl                 :float(24)
#  is_inside_month           :boolean
#  is_same_btc               :boolean
#  is_continue_increase      :boolean
#  is_continue_decrease      :boolean
#  is_fake_breakout_increase :boolean
#  is_fake_breakout_decrease :boolean
#  continue_by_year          :integer
#  continue_by_month         :integer
#  merchandise_rate_id       :bigint           not null
#  candlestick_month_id      :bigint           not null
#  year                      :integer
#  month                     :integer
#  timestamp                 :integer
#  parent_id                 :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class CandlestickMonthInfo < ApplicationRecord
  belongs_to :merchandise_rate
  belongs_to :candlestick_month
end
