class Receiver < ApplicationRecord
  belongs_to :giver
  has_many :product_actions, dependent: :destroy

  validates :giver, presence: true
end

# == Schema Information
#
# Table name: receivers
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  email      :string
#  giver_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gift_limit :integer
#
# Indexes
#
#  index_receivers_on_giver_id  (giver_id)
#
# Foreign Keys
#
#  fk_rails_...  (giver_id => givers.id)
#
