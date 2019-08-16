class Relation < ApplicationRecord
  has_many :receivers, dependent: :nullify

  validates :name, presence: true
end

# == Schema Information
#
# Table name: relations
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
