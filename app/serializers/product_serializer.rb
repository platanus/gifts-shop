class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :price, :store_name, :image_url

  def store_name
    object.store.name
  end

  def image_url
    rails_blob_path(object.image, only_path: true)
  end
end
