class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :receiver_id, :fulfilled, :additional_info
end
