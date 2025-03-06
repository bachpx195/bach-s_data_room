# == Schema Information
#
# Table name: date_masters
#
#  id              :bigint           not null, primary key
#  date            :date
#  date_name       :string(255)
#  date_number     :integer
#  month           :integer
#  month_master_id :bigint           not null
#  year            :integer
#  year_master_id  :bigint           not null
#  week_master_id  :bigint           not null
#  note            :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class DateMaster < ApplicationRecord
  belongs_to :month_master
  belongs_to :year_master
  belongs_to :week_master

  def from_days_ago(day_number)
    DateMaster.find_by(date: self.date - day_number.days)
  end

  class << self
    def create_data
      first_date = Date.parse("2008-01-07")
      last_date = Date.parse("2029-12-31")
      dates_master = []

      while first_date <= last_date
        puts first_date
        dates_master.push(DateMaster.new(
          date: first_date,
          date_name: first_date.strftime("%A"),
          date_number: first_date.day,
          month: first_date.month,
          year: first_date.year,
          year_master_id: YearMaster.find_by(year: first_date.year).id,
          month_master_id: MonthMaster.find_by(year: first_date.year, month: first_date.month).id,
          week_master_id: WeekMaster.find_by(start_date: first_date.at_beginning_of_week).id
        ))
        first_date = first_date + 1
      end

      DateMaster.import(dates_master, validate: false)
    end
  end
end
