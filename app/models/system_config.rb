# == Schema Information
#
# Table name: system_configs
#
#  id         :bigint           not null, primary key
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SystemConfig < ApplicationRecord
end
