# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :merchandises
  has_many :merchandise_rates
end
