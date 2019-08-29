class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :store
  has_many :whishlists, dependent: :destroy
  has_many :product_values, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }
  validates :price, presence: true
  validates :link, presence: true
end

# == Schema Information
#
# Table name: products
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  price       :float
#  clicks      :integer          default(0)
#  link        :string
#  clicks_cost :float
#  store_id    :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
