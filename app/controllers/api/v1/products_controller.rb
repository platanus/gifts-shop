class Api::V1::ProductsController < Api::V1::BaseController
  def index
    products = GetProductsRecommendation.for(
      number_of_products: recommendation_params[:number_of_products],
      min_price: recommendation_params[:min_price],
      max_price: recommendation_params[:max_price],
    )
    respond_with products
  end

  private

  def recommendation_params
    params.require(:number_of_products)
    params.permit(:number_of_products, :min_price, :max_price)
  end
end
