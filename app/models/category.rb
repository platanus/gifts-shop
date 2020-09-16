class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  def self.randomized(seed = 0.0)
    connection.execute(Arel.sql("SELECT SETSEED(#{seed})"))
    order(Arel.sql('RANDOM()'))
  end
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
