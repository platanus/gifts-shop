class AttributeValue < ApplicationRecord
  belongs_to :attribute
  has_many :product_values, dependent: :destroy
end

# == Schema Information
#
# Table name: attribute_values
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  attribute_id :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_attribute_values_on_attribute_id  (attribute_id)
#
# Foreign Keys
#
#  fk_rails_...  (attribute_id => attributes.id)
#
