# == Schema Information
#
# Table name: range_candlestick_dates
#
#  id                    :bigint           not null, primary key
#  date                  :date
#  mean_oc               :float(24)
#  mean_hl               :float(24)
#  standard_deviation_oc :float(24)
#  standard_deviation_hl :float(24)
#  candlestick_date_id   :bigint           not null
#  merchandise_rate_id   :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class RangeCandlestickDate < ApplicationRecord
  # Window là số ngày (hoặc giờ) bạn chọn để tính trung bình và độ lệch chuẩn của biến động
  C_WINDOW = 7

  belongs_to :candlestick_date
  belongs_to :merchandise_rate

  class << self
    def delete_duplicate
      RangeCandlestickDate.where.not(id: RangeCandlestickDate.group(:candlestick_date_id, :candlestick_date_id).select("min(id)")).destroy_all
    end
  end
end
