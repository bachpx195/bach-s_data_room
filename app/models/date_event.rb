# == Schema Information
#
# Table name: date_events
#
#  id                  :bigint           not null, primary key
#  date_master_id      :bigint           not null
#  event_master_id     :bigint           not null
#  merchandise_rate_id :bigint           not null
#  candlestick_date_id :bigint           not null
#  note                :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class DateEvent < ApplicationRecord
  belongs_to :date_master
  belongs_to :event_master
  belongs_to :merchandise_rate
  belongs_to :candlestick_date, optional: true
end
