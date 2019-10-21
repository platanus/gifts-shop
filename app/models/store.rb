class Store < ApplicationRecord
  include LedgerizerAccountable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  belongs_to :region

  validates :name, presence: true, length: { minimum: 5, maximum: 20 }

  def final_balance
    account&.ledger_balance&.format || "$0"
  end

  def update_has_enough_balance
    cpc = ProductAction::PROMOTED_CLICK_COST
    update(has_enough_balance: account.ledger_balance.fractional >= cpc)
  end

  def ledger_lines
    lines = account&.ledger_lines || []
    lines.map do |line|
      {
        entry_date: line.entry_date,
        amount: line.amount,
        description: get_description(line),
        balance: get_balance_from(line.created_at)
      }
    end
  end

  def get_balance_from(date)
    sum = account.ledger_lines.where('created_at <= ?', date).sum(:amount_cents)
    Money.from_amount(sum)
  end

  def get_description(line)
    return "Abono" if line.entry_code == "store_deposit"

    product_name = ProductAction.find(line.document_id).product.name
    "Click en #{product_name}"
  end

  def account
    accounts.first
  end
end

# == Schema Information
#
# Table name: stores
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  name                   :string
#  balance                :float            default(0.0)
#  region_id              :bigint(8)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  has_enough_balance     :boolean          default(FALSE)
#
# Indexes
#
#  index_stores_on_email                 (email) UNIQUE
#  index_stores_on_region_id             (region_id)
#  index_stores_on_reset_password_token  (reset_password_token) UNIQUE
#
