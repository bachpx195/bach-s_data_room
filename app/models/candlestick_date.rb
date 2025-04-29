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
#  range_oc_type       :string(45)
#  return_hl           :float(24)
#  range_hl_type       :string(45)
#  open                :float(24)
#  high                :float(24)
#  close               :float(24)
#  low                 :float(24)
#  volumn              :float(24)
#  timestamp           :string(255)
#  parent_id           :integer
#  parent_month_id     :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CandlestickDate < ApplicationRecord
  include CandlestickCommon

  C_TYPE = "days".freeze

  # Window là số ngày (hoặc giờ) bạn chọn để tính trung bình và độ lệch chuẩn của biến động
  C_WINDOW = 7
  C_RANGE = "range_candlestick_date"

  has_one :range_candlestick_date, dependent: :destroy

  has_many :candlestick_hours, foreign_key: "parent_id"
  has_many :label_candlestick_dates, dependent: :destroy
  has_many :labels, through: :label_candlestick_dates
  has_many :pattern_candlestick_dates, dependent: :destroy
  has_many :patterns, through: :label_candlestick_dates

  belongs_to :merchandise_rate

  scope :null_parent_month_id, -> do
    where(parent_month_id: nil)
  end

  class << self
    # Mục đích là tìm 100 giá trị trước và sau date được chọn
    def range_between_date date, limit
      [date - 100.days, date + limit.days, date + 1.days]
    end

    def delete_duplicate
      CandlestickDate.where.not(id: CandlestickDate.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end

    def list_merchandise_rate_id time_type="date"
      sql = "SELECT DISTINCT merchandise_rate_id FROM bach_s_data_room_development.candlestick_dates;"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  def update_parent_id
    return if self.check_date_is_current_week

    self.update(parent_id: CandlestickWeek.find_by(date: self.date.at_beginning_of_week.strftime("%Y-%m-%d"), merchandise_rate_id: self.merchandise_rate_id)&.id)
  end

  def update_parent_month_id
    return if self.check_date_is_current_month
    c_date = self.date

    self.update(parent_month_id: CandlestickMonth.find_by(year: c_date.year, month: c_date.month)&.id)
  end

  def check_date_is_current_week
    self.date >= Time.zone.now.at_beginning_of_week
  end

  def check_date_is_current_month
    Time.now.strftime("%Y%m") == self.date.strftime("%Y%m")
  end

  def c_hour(number)
    candlestick_hours.where(hour: number).last
  end

  #cl_001
  def is_cl_001_high_pattern?
    c_before = self.before_candlestick
    return false if !c_before.present?

    self.candlestick_hours.where(hour: [ 7, 8, 9 ])
      .any? { |c_hour| c_hour.high > c_before.high }
  end

  def is_cl_001_low_pattern?
    c_before = self.before_candlestick
    return false if !c_before.present?

    self.candlestick_hours.where(hour: [ 7, 8, 9 ])
      .any? { |c_hour| c_hour.low < c_before.low }
  end
end
