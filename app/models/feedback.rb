class Feedback < ApplicationRecord
  belongs_to :receiver

  validates :fulfilled, presence: true
end

# == Schema Information
#
# Table name: feedbacks
#
#  id              :bigint(8)        not null, primary key
#  receiver_id     :bigint(8)
#  additional_info :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  fulfilled       :boolean
#
# Indexes
#
#  index_feedbacks_on_receiver_id  (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => receivers.id)
#
