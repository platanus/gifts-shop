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

  private

  def recommendation_params
    params.require(:number_of_products)
    params.permit(:number_of_products, :min_price, :max_price, :promoted)
  end

  def receiver
    receiver_id = session[:receiver_id]
    return if receiver_id.blank?

    Receiver.find_by(id: receiver_id)
  end

  def giver_id
    giver_id = session[:giver_id]
    return if giver_id.blank?

    giver_id.to_i
  end

  def redirect_to_landing_if_receiver_not_valid
    redirect_to landing_show_path unless receiver_is_valid?
  end

  def receiver_is_valid?
    receiver && giver_id && (receiver.giver_id == giver_id)
  end
end
