class GetProductsRecommendation < PowerTypes::Command.new(
  :number_of_products, min_price: false, max_price: false
)
  def perform
    Product.first(@number_of_products.to_i)
  end
end
