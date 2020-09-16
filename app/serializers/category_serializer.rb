class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :products

  def products
    ActiveModel::ArraySerializer.new(
      object.products.where(status: :approved),
      each_serializer: ProductSerializer
    )
  end
end
