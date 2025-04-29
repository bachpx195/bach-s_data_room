# == Schema Information
#
# Table name: positions
#
#  id                  :bigint           not null, primary key
#  merchandise_rate_id :bigint           not null
#  result              :string(255)
#  start_date          :datetime
#  end_date            :datetime
#  order_type          :string(255)
#  leverage            :integer
#  entry               :float(24)
#  escape              :float(24)
#  return_usdt         :float(24)
#  return_change       :float(24)
#  position_total      :float(24)
#  balance             :float(24)
#  note                :text(65535)
#  period_min          :integer
#  period_hour         :integer
#  period_day          :float(24)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Position < ApplicationRecord
  belongs_to :merchandise_rate

  before_save :cal_result
  before_save :cal_balance
  before_save :cal_period_min
  before_save :cal_period_hour
  before_save :cal_period_day

  private
  def cal_result
    return if self.result.present?
    self.result = self.return_usdt >= 0 ? 'thang' : 'thua' 
  end

  def cal_balance
    return if self.balance.present?
    self.balance = (self.position_total / self.leverage).to_f.round(2)
  end

  def cal_period_min
    return if self.period_min.present?
    self.period_min = (self.end_date - self.start_date) / (60)
  end

  def cal_period_hour
    return if self.period_hour.present?
    self.period_hour = (self.end_date - self.start_date) / 60 / 60
  end

  def cal_period_day
    return if self.period_day.present?
    self.period_day = ((self.end_date - self.start_date) / 60 / 60 / 24).to_f.round(1)
  end
end
