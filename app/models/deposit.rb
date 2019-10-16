class Deposit < ApplicationRecord
  include LedgerizerDocument

  belongs_to :store
  belongs_to :organization

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_save :execute_store_deposit

  private

  def execute_store_deposit
    DepositAccounter.for(deposit: self)
  end
end

# == Schema Information
#
# Table name: deposits
#
#  id              :bigint(8)        not null, primary key
#  store_id        :bigint(8)
#  amount          :bigint(8)        default(0), not null
#  amount_currency :string           default("CLP"), not null
#  organization_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deposit_time    :date             not null
#
# Indexes
#
#  index_deposits_on_organization_id  (organization_id)
#  index_deposits_on_store_id         (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (store_id => stores.id)
#
