class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :products, :website, :facebook, :instagram, :twitter

  def products
    ActiveModel::ArraySerializer.new(
      object.products.order(:price).where(status: :approved),
      each_serializer: ProductSerializer
    )
  end
end
