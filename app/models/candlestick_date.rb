# == Schema Information
#
# Table name: candlestick_dates
#
#  id                  :bigint           not null, primary key
#  merchandise_rate_id :bigint           not null
#  date                :date
#  date_name           :string(255)
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
#  parent_month_id     :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CandlestickDate < ApplicationRecord
  include CandlestickCommon

  belongs_to :merchandise_rate

  class << self
    def delete_duplicate
      CandlestickDate.where.not(id: CandlestickDate.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end

    def list_merchandise_rate_id time_type="date"
      sql = "SELECT DISTINCT merchandise_rate_id FROM bach_s_data_room_development.candlestick_dates;"
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
