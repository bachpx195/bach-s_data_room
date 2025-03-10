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
    # Mục đích là tìm 100 giá trị trước và sau date được chọn
    def range_between_date date, limit
      [date - 100.hours, date + limit.hours, date + 1.hours]
    end

    def delete_duplicate
      CandlestickHour.where.not(id: CandlestickHour.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end

    def list_merchandise_rate_id time_type="date"
      sql = "SELECT DISTINCT merchandise_rate_id FROM bach_s_data_room_development.candlestick_hour;"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  def update_parent_id
    return if self.check_hour_is_current_date

    self.update(parent_id: CandlestickDate.find_by(date: date_with_binane)&.id)
  end

  def check_hour_is_current_hour
    Time.now.strftime("%Y%m%d%H") === self.date.strftime("%Y%m%d%H")
  end

  def check_hour_is_current_date
    Time.now.strftime("%Y%m%d") === self.date_with_binance.strftime("%Y%m%d")
  end
end
