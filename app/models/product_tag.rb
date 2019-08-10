class ProductTag < ApplicationRecord
  belongs_to :product
  belongs_to :category_value
end

# == Schema Information
#
# Table name: product_tags
#
#  id                :bigint(8)        not null, primary key
#  product_id        :bigint(8)
#  category_value_id :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_product_tags_on_category_value_id  (category_value_id)
#  index_product_tags_on_product_id         (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_value_id => category_values.id)
#  fk_rails_...  (product_id => products.id)
#
