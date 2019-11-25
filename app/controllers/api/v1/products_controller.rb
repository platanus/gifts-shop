class Api::V1::ProductsController < Api::V1::BaseController
  before_action :redirect_to_landing_if_receiver_not_valid, only: :index

  def index
    products = GetProductsRecommendation.for(
      receiver: receiver,
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

  def redirect_to_landing_if_receiver_not_valid
    redirect_to landing_show_path unless receiver_is_valid?
  end

  def receiver_is_valid?
    receiver && giver && (receiver.giver_id == giver.id)
  end
end
