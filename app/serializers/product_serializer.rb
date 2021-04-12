class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :price, :store_name, :image_url,
             :link, :description, :category_id, :clicks

  def store_name
    object.store.name
  end

  def image_url
    url_for(object.image.variant(resize: "650x650").processed)
  end
end
