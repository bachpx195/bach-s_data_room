# == Schema Information
#
# Table name: year_masters
#
#  id         :bigint           not null, primary key
#  start_date :date
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class YearMaster < ApplicationRecord
  has_many :month_masters

  class << self
    def create_data
      first_date = Date.parse("2008-01-01")
      last_date = Date.parse("2030-01-01")

      while first_date <= last_date
        puts first_date
        YearMaster.create(start_date: first_date, year: first_date.year)
        first_date = first_date + 365.days
      end
    end
  end
end
