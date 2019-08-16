class Receiver < ApplicationRecord
  belongs_to :giver
  belongs_to :relation
  has_one :reminder, dependent: :destroy
  has_one :whishlist, dependent: :destroy

  validates :relation, presence: true
  validates :giver, presence: true
end

# == Schema Information
#
# Table name: receivers
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  email       :string
#  giver_id    :bigint(8)
#  relation_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_receivers_on_giver_id     (giver_id)
#  index_receivers_on_relation_id  (relation_id)
#
# Foreign Keys
#
#  fk_rails_...  (giver_id => givers.id)
#  fk_rails_...  (relation_id => relations.id)
#
