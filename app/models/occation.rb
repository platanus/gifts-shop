class Occation < ApplicationRecord
  has_many :reminders, dependent: :destroy
end

# == Schema Information
#
# Table name: occations
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
