class ProductShare < ApplicationRecord
  include PowerTypes::Observable
  belongs_to :product
  enum platform: { email: 0, whatsapp: 1 }

  validates :platform, presence: true
  with_options if: :shared_with_email? do |shared_by_email|
    shared_by_email.validates :to_email, presence: true, format: Devise::email_regexp
  end

  delegate :store, to: :product

  def shared_with_email?
    platform == 'email'
  end
end

# == Schema Information
#
# Table name: product_shares
#
#  id         :bigint(8)        not null, primary key
#  platform   :bigint(8)
#  product_id :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  to_email   :string
#
# Indexes
#
#  index_product_shares_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
