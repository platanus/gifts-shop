class ProductAction < ApplicationRecord
  belongs_to :product
  belongs_to :receiver
  enum action_type: { display: 0, like: 1, dislike: 2 }

  validates :action_type, presence: true
end

# == Schema Information
#
# Table name: product_actions
#
#  id          :bigint(8)        not null, primary key
#  product_id  :bigint(8)
#  receiver_id :bigint(8)
#  action_type :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_product_actions_on_product_id   (product_id)
#  index_product_actions_on_receiver_id  (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (receiver_id => receivers.id)
#
