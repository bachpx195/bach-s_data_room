# == Schema Information
#
# Table name: metric_dates
#
#  id                     :bigint           not null, primary key
#  merchandise_rate_id    :bigint
#  candlestick_date_id    :bigint
#  highest_hour_return_oc :integer
#  highest_hour_return_hl :integer
#  highest_hour_volumn    :integer
#  hour_range_33_per      :float(24)
#  hour_range_67_per      :float(24)
#  reverse_increase_hour  :integer
#  reverse_decrease_hour  :integer
#  continue_increase_hour :integer
#  continue_decrease_hour :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class MetricDate < ApplicationRecord
  belongs_to :merchandise_rate
  belongs_to :candlestick_date
end
