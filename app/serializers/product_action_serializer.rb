class ProductActionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :product_id, :receiver_id, :action_type
end
