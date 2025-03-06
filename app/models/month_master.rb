# == Schema Information
#
# Table name: month_masters
#
#  id             :bigint           not null, primary key
#  start_date     :date
#  month          :integer
#  year           :integer
#  year_master_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class MonthMaster < ApplicationRecord
  belongs_to :year_master

  class << self
    def create_data
      first_date = Date.parse("2008-01-01")
      last_date = Date.parse("2030-01-01")

      while first_date <= last_date
        puts first_date
        year = first_date.year
        year_master = YearMaster.find_by(year: year)
        MonthMaster.create(start_date: first_date, month: first_date.month, year: first_date.year, year_master_id: year_master.id)
        first_date = first_date + 1.months
      end
    end
  end
end
