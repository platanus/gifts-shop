class ProductValue < ApplicationRecord
  belongs_to :product
  belongs_to :attribute_value
end

# == Schema Information
#
# Table name: product_values
#
#  id                 :bigint(8)        not null, primary key
#  product_id         :bigint(8)
#  attribute_value_id :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_product_values_on_attribute_value_id  (attribute_value_id)
#  index_product_values_on_product_id          (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (attribute_value_id => attribute_values.id)
#  fk_rails_...  (product_id => products.id)
#
