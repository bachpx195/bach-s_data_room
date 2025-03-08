# == Schema Information
#
# Table name: candlestick_months
#
#  id                  :bigint           not null, primary key
#  merchandise_rate_id :bigint           not null
#  date                :date
#  open                :float(24)
#  high                :float(24)
#  close               :float(24)
#  low                 :float(24)
#  volumn              :float(24)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CandlestickMonth < ApplicationRecord
  belongs_to :merchandise_rate

  scope :sort_by_type, -> sort_type = :desc do
    order(date: sort_type)
  end

  class << self
    def delete_duplicate
      CandlestickMonth.where.not(id: CandlestickMonth.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end
  end
end
