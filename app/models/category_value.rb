class CategoryValue < ApplicationRecord
  belongs_to :category
  has_many :product_tags, dependent: :destroy
end

# == Schema Information
#
# Table name: category_values
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  category_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_category_values_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
