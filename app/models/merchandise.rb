# == Schema Information
#
# Table name: merchandises
#
#  id         :bigint           not null, primary key
#  tag_id     :bigint           not null
#  name       :string(255)
#  slug       :string(255)
#  founder    :string(255)
#  company    :string(255)
#  country    :string(255)
#  about      :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Merchandise < ApplicationRecord
  has_many :merchandise_rates, ->(object) { where("select * from merchandise_rates where merchandise_rates.base_id = ?", object.id) }, class_name: "MerchandiseRate"
  belongs_to :tag
end
