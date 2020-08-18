class Api::V1::ProductsController < Api::V1::BaseController
  def index
    products = GetProductsRecommendation.for(
      number_of_products: recommendation_params[:number_of_products],
      min_price: recommendation_params[:min_price],
      max_price: recommendation_params[:max_price],
      promoted: recommendation_params[:promoted]
    )
    respond_with products
  end

  def update
    product = Product.find_by(id: update_params[:id]).toggle(update_params[:type]).save
    respond_with product
  end

  private

  def recommendation_params
    params.require(:number_of_products)
    params.permit(:number_of_products, :min_price, :max_price, :promoted)
  end

  def update_params
    params.permit(:id, :type)
  end
end
