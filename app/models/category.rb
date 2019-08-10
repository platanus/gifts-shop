class Category < ApplicationRecord
  has_many :category_values, dependent: :destroy
  has_many :product_tags, through: :attribute_values
end

# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
