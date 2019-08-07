class Region < ApplicationRecord
  has_many :givers, dependent: :nullify
  has_many :stores, dependent: :nullify
end

# == Schema Information
#
# Table name: regions
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
