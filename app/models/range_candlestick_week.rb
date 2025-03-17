# == Schema Information
#
# Table name: range_candlestick_weeks
#
#  id                    :bigint           not null, primary key
#  date                  :date
#  mean_oc               :float(24)
#  mean_hl               :float(24)
#  standard_deviation_oc :float(24)
#  standard_deviation_hl :float(24)
#  candlestick_week_id   :bigint           not null
#  merchandise_rate_id   :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class RangeCandlestickWeek < ApplicationRecord
  # Window là số ngày (hoặc giờ) bạn chọn để tính trung bình và độ lệch chuẩn của biến động
  C_WINDOW = 4

  belongs_to :candlestick_week
  belongs_to :merchandise_rate
end
