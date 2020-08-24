class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true
  validates :description, presence: true
end

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
