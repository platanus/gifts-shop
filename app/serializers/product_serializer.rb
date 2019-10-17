class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :price, :store_name, :image_url, :link, :promoted

  def store_name
    object.store.name
  end

  def promoted
    object.store.has_enough_balance? && object.promoted
  end

  def image_url
    rails_blob_path(object.image, only_path: true)
  end
end
