class Organization < ApplicationRecord
  include LedgerizerTenant
  include LedgerizerAccountable

  has_many :deposits, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
end

# == Schema Information
#
# Table name: organizations
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
