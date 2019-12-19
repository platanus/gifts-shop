class Feedback < ApplicationRecord
  belongs_to :receiver

  enum response: { gift_found: 0, gift_not_found: 1, closed: 2 }

  validates :response, presence: true
end

# == Schema Information
#
# Table name: feedbacks
#
#  id              :bigint(8)        not null, primary key
#  receiver_id     :bigint(8)
#  response        :integer
#  additional_info :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_feedbacks_on_receiver_id  (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => receivers.id)
#
