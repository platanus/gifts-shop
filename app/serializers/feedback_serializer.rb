class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :receiver_id, :response, :additional_info
end
