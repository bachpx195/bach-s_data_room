# == Schema Information
#
# Table name: merchandise_rates
#
#  id         :bigint           not null, primary key
#  tag_id     :bigint           not null
#  name       :string(255)
#  slug       :string(255)
#  base_id    :integer
#  quote_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MerchandiseRate < ApplicationRecord
  belongs_to :tag
end
