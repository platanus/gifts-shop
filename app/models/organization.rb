class Organization < ApplicationRecord

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }

  def self.platanus
    find_by(name: 'Platanus')
  end
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
