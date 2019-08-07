class Attribute < ApplicationRecord
  has_many :attribute_values, dependent: :destroy
  has_many :product_values, through: :attribute_values
end

# == Schema Information
#
# Table name: attributes
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
