# == Schema Information
#
# Table name: patterns
#
#  id                  :bigint           not null, primary key
#  name                :string(255)
#  slug                :string(255)
#  description         :text(65535)
#  pattern_type        :string(255)
#  merchandise_rate_id :bigint           not null
#  parent_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Pattern < ApplicationRecord
  has_many :pattern_candlestick_dates
  has_many :candlestick_dates, through: :pattern_candlestick_dates
  has_many :child_patterns, class_name: 'Pattern', foreign_key: 'parent_id'

  belongs_to :merchandise_rate
  belongs_to :parent_pattern, class_name: 'Pattern', foreign_key: 'parent_id', optional: true
end
