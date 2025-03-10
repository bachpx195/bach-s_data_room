# == Schema Information
#
# Table name: event_masters
#
#  id                  :bigint           not null, primary key
#  merchandise_rate_id :bigint           not null
#  name                :string(255)
#  slug                :string(255)
#  description         :text(65535)
#  time                :string(255)
#  note                :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class EventMaster < ApplicationRecord
  has_many :date_events
  has_many :date_masters, through: :date_events

  belongs_to :merchandise_rate
end
