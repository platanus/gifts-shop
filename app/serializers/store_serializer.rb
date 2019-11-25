class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :low_balance

  def low_balance
    !object&.has_enough_balance? && !object.products.where(promoted: true).count.zero?
  end
end
