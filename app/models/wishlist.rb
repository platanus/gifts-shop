class Wishlist < ApplicationRecord
  belongs_to :product
  belongs_to :receiver
end

# == Schema Information
#
# Table name: wishlists
#
#  id          :bigint(8)        not null, primary key
#  product_id  :bigint(8)
#  receiver_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_wishlists_on_product_id   (product_id)
#  index_wishlists_on_receiver_id  (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (receiver_id => receivers.id)
#
