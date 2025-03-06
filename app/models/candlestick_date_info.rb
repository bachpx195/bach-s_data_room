# == Schema Information
#
# Table name: candlestick_date_infos
#
#  id                        :bigint           not null, primary key
#  date                      :date
#  date_name                 :string(255)
#  candlestick_type          :string(255)
#  return_oc                 :float(24)
#  return_hl                 :float(24)
#  is_inside_day             :boolean
#  is_same_btc               :boolean
#  is_continue_increase      :boolean
#  is_continue_decrease      :boolean
#  is_fake_breakout_increase :boolean
#  is_fake_breakout_decrease :boolean
#  continue_by_day           :integer
#  merchandise_rate_id       :bigint           not null
#  candlestick_date_id       :bigint           not null
#  timestamp                 :integer
#  parent_id                 :integer
#  parent_month_id           :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class CandlestickDateInfo < ApplicationRecord
  belongs_to :merchandise_rate
  belongs_to :candlestick_day
end
