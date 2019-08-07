class Reminder < ApplicationRecord
  self.ignored_columns = ["email"]
  belongs_to :receiver
  belongs_to :occation
end

# == Schema Information
#
# Table name: reminders
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  date         :datetime
#  occation_id  :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  receivers_id :bigint(8)
#
# Indexes
#
#  index_reminders_on_occation_id   (occation_id)
#  index_reminders_on_receivers_id  (receivers_id)
#
