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
#  timestamp           :string(255)
#  parent_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CandlestickWeek < ApplicationRecord
  include CandlestickCommon

  C_TYPE = "weeks".freeze

  has_many :label_candlestick_weeks, dependent: :destroy
  has_many :labels, through: :label_candlestick_weeks

  belongs_to :merchandise_rate
  belongs_to :week_master, optional: true

  class << self
    # Mục đích là tìm 100 giá trị trước và sau date được chọn
    def range_between_date date, limit
      [date - 100.weeks, date + limit.weeks, date + 1.weeks]
    end

    def delete_duplicate
      CandlestickWeek.where.not(id: CandlestickWeek.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end

    def list_merchandise_rate_id time_type="date"
      sql = "SELECT DISTINCT merchandise_rate_id FROM bach_s_data_room_development.candlestick_weeks;"
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
