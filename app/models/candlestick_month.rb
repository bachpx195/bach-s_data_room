# == Schema Information
#
# Table name: candlestick_months
#
#  id                  :bigint           not null, primary key
#  merchandise_rate_id :bigint           not null
#  date                :date
#  month               :integer
#  year                :integer
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
class CandlestickMonth < ApplicationRecord
  include CandlestickCommon

  belongs_to :merchandise_rate

  scope :find_monthly_candlestick, -> merchandise_rate_id do
    where(merchandise_rate_id: merchandise_rate_id)
    .order(date: :desc)
  end

  class << self
    # Mục đích là tìm 100 giá trị trước và sau date được chọn
    def range_between_date date, limit
      [date - 100.months, date + limit.months, date + 1.months]
    end

    def delete_duplicate
      CandlestickMonth.where.not(id: CandlestickMonth.group(:date, :merchandise_rate_id).select("min(id)")).destroy_all
    end

    def list_merchandise_rate_id time_type="date"
      sql = "SELECT DISTINCT merchandise_rate_id FROM bach_s_data_room_development.candlestick_months;"
      ActiveRecord::Base.connection.execute(sql)
    end

    def calculate_month_return merchandise_rate_id, using_markdown_text = false
      candlesticks = CandlestickMonth.find_monthly_candlestick(merchandise_rate_id)
      monthly_return_json = {}

      candlesticks.each do |c|
        current_time = Time.zone.now
        c_year = c.year
        c_month = c.month 
        next if c_year == current_time.year && c_month == current_time.month
        monthly_return_json[c_year] = {} if !monthly_return_json[c_year].present?
        monthly_return = ((c.close - c.open)*100/c.open).round(2)

        monthly_return_json[c_year][c_month] = if using_markdown_text
          color = monthly_return > 0 ? 'green' : 'red'
          text = monthly_return > 0 ? "+#{monthly_return}" : "-#{monthly_return.abs}"
          "$${\\color{#{color}}#{text}}$$"
        else
          monthly_return
        end
      end

      if using_markdown_text
        monthly_return_json.keys.each do |key|
          monthly_return_json[key] = monthly_return_json[key].values.reverse.join("|")
        end
      end

      monthly_return_json
    end
  end
end
