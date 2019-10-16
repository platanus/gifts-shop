class Giver < ApplicationRecord
  has_many :receivers, dependent: :destroy
  belongs_to :region

  validates :region, presence: true
end

# == Schema Information
#
# Table name: givers
#
#  id         :bigint(8)        not null, primary key
#  email      :string
#  region_id  :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_givers_on_region_id  (region_id)
#
