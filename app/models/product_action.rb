class ProductAction < ApplicationRecord
  include PowerTypes::Observable
  include LedgerizerDocument

  belongs_to :product
  enum action_type: { display: 0, like: 1, dislike: 2, click: 3, promoted_click: 4 }

  validates :action_type, presence: true

  delegate :store, to: :product

  PROMOTED_CLICK_COST = ENV.fetch('CPC').to_i

  self.ignored_columns = ['receiver_id']
end

# == Schema Information
#
# Table name: product_actions
#
#  id          :bigint(8)        not null, primary key
#  product_id  :bigint(8)
#  action_type :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_product_actions_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
