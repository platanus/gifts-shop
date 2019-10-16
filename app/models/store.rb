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
    accounts.first.ledger_balance.format
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
#
# Indexes
#
#  index_stores_on_email                 (email) UNIQUE
#  index_stores_on_region_id             (region_id)
#  index_stores_on_reset_password_token  (reset_password_token) UNIQUE
#
